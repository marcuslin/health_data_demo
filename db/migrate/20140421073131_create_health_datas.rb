class CreateHealthDatas < ActiveRecord::Migration
  def change
    create_table :health_datas do |t|
      t.string :patient_id
      t.string :created_month
      t.decimal :body_weight, :precision => 3, :scale => 2
      t.integer :body_height
      t.integer :blood_pressure
      t.integer :SBP
      t.integer :DBP
      t.decimal :MBP, :precision => 3, :scale => 5
      t.integer :pulse_rate
      t.integer :SpO2
      t.integer :blood_sugar
      t.decimal :AC, :precision => 2, :scale => 1
      t.decimal :DC, :precision => 2, :scale => 1

      t.timestamps
    end
  end
end
