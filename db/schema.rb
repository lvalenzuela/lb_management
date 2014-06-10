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

ActiveRecord::Schema.define(version: 20140610185714) do

  create_table "notifications", force: true do |t|
    t.integer  "userid"
    t.string   "subject",    limit: 100
    t.text     "message"
    t.integer  "seen"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "request_areas", force: true do |t|
    t.string   "areaname",     limit: 45
    t.integer  "area_manager"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "request_priorities", force: true do |t|
    t.string   "description", limit: 45
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "request_statuses", force: true do |t|
    t.string   "description", limit: 45
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "request_tags", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "requests", force: true do |t|
    t.integer  "userid"
    t.string   "subject",    limit: 100
    t.integer  "receiverid"
    t.integer  "areaid"
    t.integer  "priorityid"
    t.integer  "statusid"
    t.text     "request",    limit: 2147483647
    t.date     "duedate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_reports", force: true do |t|
    t.integer  "userid"
    t.string   "firstname",           limit: 45
    t.string   "lastname",            limit: 45
    t.string   "institution",         limit: 45
    t.string   "department",          limit: 45
    t.string   "username",            limit: 45
    t.integer  "courseid"
    t.string   "coursename",          limit: 45
    t.integer  "roleid"
    t.string   "rolename",            limit: 45
    t.datetime "lastaccess"
    t.integer  "total_sessions"
    t.integer  "current_sessions"
    t.integer  "p_sessions"
    t.integer  "a_sessions"
    t.integer  "t_sessions"
    t.float    "avg_inclasswork"
    t.float    "avg_attitude"
    t.float    "grade_course"
    t.float    "grade_homework"
    t.float    "grade_writing_tests"
    t.float    "grade_tests_teg"
    t.float    "grade_tests"
    t.float    "grade_oral_tests"
    t.integer  "assignments_ontime"
    t.integer  "total_assignments"
    t.datetime "created_at"
  end

  create_table "user_types", force: true do |t|
    t.string   "description", limit: 45
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "firstname",    limit: 45
    t.string   "lastname",     limit: 45
    t.string   "username",     limit: 45
    t.integer  "permissionid"
    t.string   "password"
    t.string   "institution",  limit: 45
    t.string   "department",   limit: 45
    t.string   "email",        limit: 45
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
