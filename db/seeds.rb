# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts 'create sample patient'
patient = Patient.new :patient_name => 'Marcus'
patient.save
puts 'finish crating patient: ' << patient.patient_name
puts 'create sample health history'
sample_data = [{:month => '01', :weight => '89.2', :height => '175', :blood_pressure => '', :SBP => 150, :DBP => 90, :MBP => '95', :pulse_rate => '78', :SpO2 => '95', :blood_sugar => '', :AC => '7', :PC => '9.1' },
               {:month => '02', :weight => '90', :height => '175', :blood_pressure => '', :SBP => 147, :DBP => 87, :MBP => '92.5', :pulse_rate => '82', :SpO2 => '0', :blood_sugar => '', :AC => '7.2', :PC => '10' },
               {:month => '03', :weight => '91', :height => '175', :blood_pressure => '', :SBP => 160, :DBP => 88, :MBP => '97.33333', :pulse_rate => '79', :SpO2 => '96', :blood_sugar => '', :AC => '6.8', :PC => '8.6' },
               ]
sample_data.each do |s|
  recorded_data = HealthHistory.new :patient_id => patient.id, :recorded_year => '2014',
                                    :recorded_month => s[:month], :body_weight => s[:weight],
                                    :body_height => s[:height], :blood_pressure => '',
                                    :SBP => s[:SBP], :DBP => s[:DBP],
                                    :MBP => s[:MBP], :pulse_rate => s[:pulse_rate],
                                    :SpO2 => s[:SpO2], :blood_sugar => '',
                                    :AC => s[:AC], :PC => s[:PC]
  recorded_data.save
end
puts 'finish inporting sample data'