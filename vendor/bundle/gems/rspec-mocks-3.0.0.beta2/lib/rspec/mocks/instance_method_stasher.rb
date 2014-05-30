module RSpec
  module Mocks
    # @private
    class InstanceMethodStasher
      def initialize(object, method)
        @object = object
        @method = method
        @klass = (class << object; self; end)

        @original_method = nil
        @method_is_stashed = false
      end

      attr_reader :original_method

      if RUBY_VERSION.to_f < 1.9
        # @private
        def method_is_stashed?
          @method_is_stashed
        end

        # @private
        def stash
          return if !method_defined_directly_on_klass? || @method_is_stashed

          @klass.__send__(:alias_method, stashed_method_name, @method)
          @method_is_stashed = true
        end

        # @private
        def stashed_method_name
          "obfuscated_by_rspec_mocks__#{@method}"
        end
        private :stashed_method_name

        # @private
        def restore
          return unless @method_is_stashed

          if @klass.__send__(:method_defined?, @method)
            @klass.__send__(:undef_method, @method)
          end
          @klass.__send__(:alias_method, @method, stashed_method_name)
          @klass.__send__(:remove_method, stashed_method_name)
          @method_is_stashed = false
        end
      else

        # @private
        def method_is_stashed?
          !!@original_method
        end

        # @private
        def stash
          return if !method_defined_directly_on_klass?
          @original_method ||= ::RSpec::Support.method_handle_for(@object, @method)
        end

        # @private
        def restore
          return unless @original_method

          if @klass.__send__(:method_defined?, @method)
            @klass.__send__(:undef_method, @method)
          end

          @klass.__send__(:define_method, @method, @original_method)
          @original_method = nil
        end
      end

      private

      # @private
      def method_defined_directly_on_klass?
        method_defined_on_klass? && method_owned_by_klass?
      end

      # @private
      def method_defined_on_klass?(klass = @klass)
        MethodReference.method_defined_at_any_visibility?(klass, @method)
      end

      def method_owned_by_klass?
        owner = @klass.instance_method(@method).owner

        # On Ruby 2.0.0+ the owner of a method on a class which has been
        # `prepend`ed may actually be an instance, e.g.
        # `#<MyClass:0x007fbb94e3cd10>`, rather than the expected `MyClass`.
        owner = owner.class unless Module === owner

        # On some 1.9s (e.g. rubinius) aliased methods
        # can report the wrong owner. Example:
        # class MyClass
        #   class << self
        #     alias alternate_new new
        #   end
        # end
        #
        # MyClass.owner(:alternate_new) returns `Class` when incorrect,
        # but we need to consider the owner to be `MyClass` because
        # it is not actually available on `Class` but is on `MyClass`.
        # Hence, we verify that the owner actually has the method defined.
        # If the given owner does not have the method defined, we assume
        # that the method is actually owned by @klass.
        owner == @klass || !(method_defined_on_klass?(owner))
      end
    end
  end
end