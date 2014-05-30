class Patient < ActiveRecord::Base
  has_many :health_histories
end
