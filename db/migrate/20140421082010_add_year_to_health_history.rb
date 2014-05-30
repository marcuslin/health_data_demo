class AddYearToHealthHistory < ActiveRecord::Migration
  def change
    add_column :health_histories, :recorded_year, :string
    rename_column :health_histories, :created_month, :recorded_month
  end
end
