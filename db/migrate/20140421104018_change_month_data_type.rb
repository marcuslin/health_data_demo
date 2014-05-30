class ChangeMonthDataType < ActiveRecord::Migration
  def change
    change_column :health_histories, :recorded_month, :integer
  end
end
