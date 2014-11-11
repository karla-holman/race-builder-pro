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

ActiveRecord::Schema.define(version: 20141105073111) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: true do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "key"
    t.text     "parameters"
    t.integer  "recipient_id"
    t.string   "recipient_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type", using: :btree
  add_index "activities", ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type", using: :btree
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type", using: :btree

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "datatype"
  end

  create_table "conditions", force: true do |t|
    t.string   "name"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "lowerbound"
    t.integer  "upperbound"
    t.string   "value"
  end

  create_table "days", force: true do |t|
    t.date     "date"
    t.integer  "field_size"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tel_id"
  end

  create_table "equipment", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.boolean  "required"
  end

  create_table "horse_conditions", force: true do |t|
    t.integer  "horse_id"
    t.integer  "condition_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "horse_equipments", force: true do |t|
    t.integer  "horse_id"
    t.integer  "equipment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "horse_meets", force: true do |t|
    t.integer  "horse_id"
    t.integer  "meet_id"
    t.integer  "starts"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "horseraces", force: true do |t|
    t.integer  "horse_id"
    t.integer  "race_id"
    t.datetime "entered"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
  end

  create_table "horses", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "gender"
    t.string   "birth_place"
    t.integer  "starts"
    t.integer  "wins"
    t.integer  "owner_id"
    t.integer  "trainer_id"
    t.string   "POB"
    t.date     "last_win"
    t.decimal  "last_claiming_level"
    t.string   "URL"
    t.integer  "week_running"
    t.integer  "birth_year"
    t.integer  "status_id"
  end

  add_index "horses", ["name"], name: "index_horses_on_name", unique: true, using: :btree

  create_table "meets", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer  "race_days"
  end

  create_table "notifications", force: true do |t|
    t.integer  "send_id"
    t.integer  "recv_id"
    t.string   "action"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pending_conditions", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "action"
    t.integer  "horse_id"
    t.integer  "condition_id"
  end

  create_table "race_conditions", force: true do |t|
    t.integer  "race_id"
    t.integer  "condition_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "race_winners", force: true do |t|
    t.integer  "race_id"
    t.integer  "horse_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "races", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
    t.string   "status"
    t.string   "type"
    t.decimal  "distance"
    t.string   "distance_type"
    t.integer  "day_id"
    t.string   "category"
  end

  create_table "statuses", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tels", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "meet_id"
    t.integer  "week_number"
    t.date     "start_date"
    t.date     "end_date"
    t.boolean  "published",   default: false
    t.boolean  "closed",      default: false
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role"
    t.string   "phone"
    t.string   "name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
