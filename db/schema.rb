# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140421104018) do

  create_table "health_histories", force: true do |t|
    t.string   "patient_id"
    t.integer  "recorded_month", limit: 255
    t.decimal  "body_weight",                precision: 3, scale: 2
    t.integer  "body_height"
    t.integer  "blood_pressure"
    t.integer  "SBP"
    t.integer  "DBP"
    t.decimal  "MBP",                        precision: 3, scale: 5
    t.integer  "pulse_rate"
    t.integer  "SpO2"
    t.integer  "blood_sugar"
    t.decimal  "AC",                         precision: 2, scale: 1
    t.decimal  "PC",                         precision: 2, scale: 1
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "recorded_year"
  end

  create_table "patients", force: true do |t|
    t.string   "patient_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
