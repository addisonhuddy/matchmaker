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

ActiveRecord::Schema.define(version: 20160403205910) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "students", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "time_zone"
    t.string   "gatech_class"
    t.string   "gatechuname"
    t.integer  "gatechid"
    t.string   "email"
    t.text     "learning_objectives"
    t.text     "preferred_tools"
    t.string   "myers_briggs"
    t.string   "week_preferred"
    t.string   "weekend_preferred"
    t.string   "java_expertise"
    t.string   "week_array"
    t.string   "weekend_array"
    t.integer  "team_id"
  end

  add_index "students", ["team_id"], name: "index_students_on_team_id", using: :btree

  create_table "teams", force: :cascade do |t|
    t.string   "name"
    t.string   "common_hours"
    t.integer  "student_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

end
