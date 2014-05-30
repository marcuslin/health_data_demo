class RenameDcFromHealthHistories < ActiveRecord::Migration
  def change
    rename_column :health_histories, :DC, :PC
  end
end
