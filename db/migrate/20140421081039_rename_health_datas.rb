class RenameHealthDatas < ActiveRecord::Migration
  def change
    rename_table :health_datas, :health_histories
  end
end
