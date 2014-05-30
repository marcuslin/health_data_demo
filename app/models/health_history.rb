class HealthHistory < ActiveRecord::Base
  belongs_to :patient
  validates :patient_id, :body_height, :body_weight, :SBP, :DBP, :MBP, :SpO2, :AC, :PC, presence:true
end
