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

ActiveRecord::Schema.define(version: 20140528150020) do

  create_table "adodb_logsql", force: true do |t|
    t.datetime "created",                                                    null: false
    t.string   "sql0",    limit: 250,                          default: "",  null: false
    t.text     "sql1"
    t.text     "params"
    t.text     "tracer"
    t.decimal  "timer",               precision: 16, scale: 6, default: 0.0, null: false
  end

  create_table "attendance_logs", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "attendance_sessions", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "attendance_statuses", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "attforblocks", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contexts", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "courses", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "grade_grades", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "management_user_reports", force: true do |t|
    t.integer  "userid"
    t.string   "firstname",           limit: 45
    t.string   "lastname",            limit: 45
    t.string   "institution",         limit: 45
    t.string   "department",          limit: 45
    t.string   "username",            limit: 45
    t.integer  "courseid"
    t.string   "coursename",          limit: 45
    t.integer  "roleid"
    t.string   "rolename",            limit: 20
    t.datetime "lastaccess"
    t.integer  "total_sessions"
    t.integer  "current_sessions"
    t.integer  "p_sessions"
    t.integer  "a_sessions"
    t.integer  "t_sessions"
    t.integer  "avg_inclasswork"
    t.integer  "avg_attitude"
    t.float    "grade_assistance"
    t.float    "grade_homework"
    t.float    "grade_writing_tests"
    t.float    "grade_tests_teg"
    t.float    "grade_tests"
    t.float    "grade_oral_tests"
    t.datetime "entrega_alumno"
    t.datetime "duedate"
    t.datetime "enabled_date"
    t.float    "nota"
    t.datetime "created_at"
  end

  create_table "management_users", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mdl_access_control", force: true do |t|
    t.integer "objectid",                  default: 0,     null: false
    t.string  "objecttable",   limit: 127, default: "",    null: false
    t.integer "designee",                  default: 0,     null: false
    t.integer "designee_type",             default: 0,     null: false
    t.integer "everybody",                 default: 0,     null: false
    t.integer "access",                    default: 0,     null: false
    t.boolean "yesno",                     default: false, null: false
    t.integer "priority",                  default: 0,     null: false
    t.boolean "inheritable",               default: true,  null: false
    t.integer "timecreated",               default: 0,     null: false
    t.integer "timemodified",              default: 0,     null: false
  end

  add_index "mdl_access_control", ["objectid", "objecttable", "designee_type", "designee", "access", "priority"], name: "mdl_access_control_uix", unique: true, using: :btree
  add_index "mdl_access_control", ["objectid", "objecttable", "designee_type", "designee", "access", "priority"], name: "mdl_access_control_unique", unique: true, using: :btree
  add_index "mdl_access_control", ["objectid", "objecttable"], name: "mdl_access_control_oidotab_ix", using: :btree
  add_index "mdl_access_control", ["objectid"], name: "mdl_access_control_oid_ix", using: :btree
  add_index "mdl_access_control", ["objecttable"], name: "mdl_access_control_otab_ix", using: :btree

  create_table "mdl_access_index", force: true do |t|
    t.integer "access",                     default: 0,  null: false
    t.string  "objecttable",    limit: 127, default: "", null: false
    t.string  "strdescription", limit: 127, default: "", null: false
    t.string  "module",         limit: 127, default: "", null: false
    t.string  "helppage",       limit: 127, default: "", null: false
  end

  add_index "mdl_access_index", ["access", "objecttable"], name: "mdl_access_index_unique", unique: true, using: :btree

  create_table "mdl_access_inherit", force: true do |t|
    t.integer "objectid_parent",                default: 0,     null: false
    t.string  "objecttable_parent", limit: 127, default: "",    null: false
    t.integer "access_parent",                  default: 0,     null: false
    t.integer "objectid_child",                 default: 0,     null: false
    t.string  "objecttable_child",  limit: 127, default: "",    null: false
    t.integer "access_child",                   default: 0,     null: false
    t.boolean "inherit_owners",                 default: false, null: false
    t.boolean "inherit_controls",               default: false, null: false
    t.boolean "inherit_access",                 default: false, null: false
    t.integer "timecreated",                    default: 0,     null: false
    t.integer "timemodified",                   default: 0,     null: false
  end

  add_index "mdl_access_inherit", ["objectid_child", "objecttable_child"], name: "mdl_access_inherit_coidotab_ix", using: :btree
  add_index "mdl_access_inherit", ["objectid_child"], name: "mdl_access_inherit_coid_ix", using: :btree
  add_index "mdl_access_inherit", ["objectid_parent", "objecttable_parent", "access_parent", "objectid_child", "objecttable_child", "access_child"], name: "mdl_access_inherit_uix", unique: true, using: :btree
  add_index "mdl_access_inherit", ["objectid_parent", "objecttable_parent", "access_parent", "objectid_child", "objecttable_child", "access_child"], name: "mdl_access_inherit_unique", unique: true, using: :btree
  add_index "mdl_access_inherit", ["objectid_parent", "objecttable_parent"], name: "mdl_access_inherit_poidotab_ix", using: :btree
  add_index "mdl_access_inherit", ["objectid_parent"], name: "mdl_access_inherit_poid_ix", using: :btree
  add_index "mdl_access_inherit", ["objecttable_child"], name: "mdl_access_inherit_cotab_ix", using: :btree
  add_index "mdl_access_inherit", ["objecttable_parent"], name: "mdl_access_inherit_potab_ix", using: :btree

  create_table "mdl_access_owner", force: true do |t|
    t.integer "objectid",                         default: 0,    null: false
    t.string  "objecttable",          limit: 127, default: "",   null: false
    t.integer "designee",                         default: 0,    null: false
    t.integer "designee_type",                    default: 0,    null: false
    t.string  "designee_objecttable", limit: 127, default: "",   null: false
    t.boolean "inheritable",                      default: true, null: false
    t.integer "timecreated",                      default: 0,    null: false
    t.integer "timemodified",                     default: 0,    null: false
  end

  add_index "mdl_access_owner", ["objectid", "objecttable"], name: "mdl_access_owner_oidotab_uix", unique: true, using: :btree
  add_index "mdl_access_owner", ["objectid", "objecttable"], name: "mdl_access_owner_unique", unique: true, using: :btree
  add_index "mdl_access_owner", ["objectid"], name: "mdl_access_owner_oid_ix", using: :btree
  add_index "mdl_access_owner", ["objecttable"], name: "mdl_access_owner_otab_ix", using: :btree

  create_table "mdl_assign", force: true do |t|
    t.integer "course",                      limit: 8,          default: 0,      null: false
    t.string  "name",                                           default: "",     null: false
    t.text    "intro",                       limit: 2147483647,                  null: false
    t.integer "introformat",                 limit: 2,          default: 0,      null: false
    t.integer "alwaysshowdescription",       limit: 1,          default: 0,      null: false
    t.integer "nosubmissions",               limit: 1,          default: 0,      null: false
    t.integer "submissiondrafts",            limit: 1,          default: 0,      null: false
    t.integer "sendnotifications",           limit: 1,          default: 0,      null: false
    t.integer "sendlatenotifications",       limit: 1,          default: 0,      null: false
    t.integer "duedate",                     limit: 8,          default: 0,      null: false
    t.integer "allowsubmissionsfromdate",    limit: 8,          default: 0,      null: false
    t.integer "grade",                       limit: 8,          default: 0,      null: false
    t.integer "timemodified",                limit: 8,          default: 0,      null: false
    t.integer "requiresubmissionstatement",  limit: 1,          default: 0,      null: false
    t.integer "completionsubmit",            limit: 1,          default: 0,      null: false
    t.integer "cutoffdate",                  limit: 8,          default: 0,      null: false
    t.integer "teamsubmission",              limit: 1,          default: 0,      null: false
    t.integer "requireallteammemberssubmit", limit: 1,          default: 0,      null: false
    t.integer "teamsubmissiongroupingid",    limit: 8,          default: 0,      null: false
    t.integer "blindmarking",                limit: 1,          default: 0,      null: false
    t.integer "revealidentities",            limit: 1,          default: 0,      null: false
    t.string  "attemptreopenmethod",         limit: 10,         default: "none", null: false
    t.integer "maxattempts",                 limit: 3,          default: -1,     null: false
    t.integer "markingworkflow",             limit: 1,          default: 0,      null: false
    t.integer "markingallocation",           limit: 1,          default: 0,      null: false
  end

  add_index "mdl_assign", ["course"], name: "mdl_assi_cou_ix", using: :btree
  add_index "mdl_assign", ["teamsubmissiongroupingid"], name: "mdl_assi_tea_ix", using: :btree

  create_table "mdl_assign_grades", force: true do |t|
    t.integer "assignment",    limit: 8,                          default: 0,   null: false
    t.integer "userid",        limit: 8,                          default: 0,   null: false
    t.integer "timecreated",   limit: 8,                          default: 0,   null: false
    t.integer "timemodified",  limit: 8,                          default: 0,   null: false
    t.integer "grader",        limit: 8,                          default: 0,   null: false
    t.decimal "grade",                   precision: 10, scale: 5, default: 0.0
    t.integer "attemptnumber", limit: 8,                          default: 0,   null: false
  end

  add_index "mdl_assign_grades", ["assignment", "userid", "attemptnumber"], name: "mdl_assigrad_assuseatt_uix", unique: true, using: :btree
  add_index "mdl_assign_grades", ["assignment"], name: "mdl_assigrad_ass_ix", using: :btree
  add_index "mdl_assign_grades", ["attemptnumber"], name: "mdl_assigrad_att_ix", using: :btree
  add_index "mdl_assign_grades", ["userid"], name: "mdl_assigrad_use_ix", using: :btree

  create_table "mdl_assign_plugin_config", force: true do |t|
    t.integer "assignment", limit: 8,          default: 0,  null: false
    t.string  "plugin",     limit: 28,         default: "", null: false
    t.string  "subtype",    limit: 28,         default: "", null: false
    t.string  "name",       limit: 28,         default: "", null: false
    t.text    "value",      limit: 2147483647
  end

  add_index "mdl_assign_plugin_config", ["assignment"], name: "mdl_assiplugconf_ass_ix", using: :btree
  add_index "mdl_assign_plugin_config", ["name"], name: "mdl_assiplugconf_nam_ix", using: :btree
  add_index "mdl_assign_plugin_config", ["plugin"], name: "mdl_assiplugconf_plu_ix", using: :btree
  add_index "mdl_assign_plugin_config", ["subtype"], name: "mdl_assiplugconf_sub_ix", using: :btree

  create_table "mdl_assign_submission", force: true do |t|
    t.integer "assignment",    limit: 8,  default: 0, null: false
    t.integer "userid",        limit: 8,  default: 0, null: false
    t.integer "timecreated",   limit: 8,  default: 0, null: false
    t.integer "timemodified",  limit: 8,  default: 0, null: false
    t.string  "status",        limit: 10
    t.integer "groupid",       limit: 8,  default: 0, null: false
    t.integer "attemptnumber", limit: 8,  default: 0, null: false
  end

  add_index "mdl_assign_submission", ["assignment", "userid", "groupid", "attemptnumber"], name: "mdl_assisubm_assusegroatt_uix", unique: true, using: :btree
  add_index "mdl_assign_submission", ["assignment"], name: "mdl_assisubm_ass_ix", using: :btree
  add_index "mdl_assign_submission", ["attemptnumber"], name: "mdl_assisubm_att_ix", using: :btree
  add_index "mdl_assign_submission", ["userid"], name: "mdl_assisubm_use_ix", using: :btree

  create_table "mdl_assign_user_flags", force: true do |t|
    t.integer "userid",           limit: 8,  default: 0, null: false
    t.integer "assignment",       limit: 8,  default: 0, null: false
    t.integer "locked",           limit: 8,  default: 0, null: false
    t.integer "mailed",           limit: 2,  default: 0, null: false
    t.integer "extensionduedate", limit: 8,  default: 0, null: false
    t.string  "workflowstate",    limit: 20
    t.integer "allocatedmarker",  limit: 8,  default: 0, null: false
  end

  add_index "mdl_assign_user_flags", ["assignment"], name: "mdl_assiuserflag_ass_ix", using: :btree
  add_index "mdl_assign_user_flags", ["mailed"], name: "mdl_assiuserflag_mai_ix", using: :btree
  add_index "mdl_assign_user_flags", ["userid"], name: "mdl_assiuserflag_use_ix", using: :btree

  create_table "mdl_assign_user_mapping", force: true do |t|
    t.integer "assignment", limit: 8, default: 0, null: false
    t.integer "userid",     limit: 8, default: 0, null: false
  end

  add_index "mdl_assign_user_mapping", ["assignment"], name: "mdl_assiusermapp_ass_ix", using: :btree
  add_index "mdl_assign_user_mapping", ["userid"], name: "mdl_assiusermapp_use_ix", using: :btree

  create_table "mdl_assignfeedback_comments", force: true do |t|
    t.integer "assignment",    limit: 8,          default: 0, null: false
    t.integer "grade",         limit: 8,          default: 0, null: false
    t.text    "commenttext",   limit: 2147483647
    t.integer "commentformat", limit: 2,          default: 0, null: false
  end

  add_index "mdl_assignfeedback_comments", ["assignment"], name: "mdl_assicomm_ass_ix", using: :btree
  add_index "mdl_assignfeedback_comments", ["grade"], name: "mdl_assicomm_gra_ix", using: :btree

  create_table "mdl_assignfeedback_editpdf_annot", force: true do |t|
    t.integer "gradeid", limit: 8,          default: 0,       null: false
    t.integer "pageno",  limit: 8,          default: 0,       null: false
    t.integer "x",       limit: 8,          default: 0
    t.integer "y",       limit: 8,          default: 0
    t.integer "endx",    limit: 8,          default: 0
    t.integer "endy",    limit: 8,          default: 0
    t.text    "path",    limit: 2147483647
    t.string  "type",    limit: 10,         default: "line"
    t.string  "colour",  limit: 10,         default: "black"
    t.integer "draft",   limit: 1,          default: 1,       null: false
  end

  add_index "mdl_assignfeedback_editpdf_annot", ["gradeid", "pageno"], name: "mdl_assieditanno_grapag_ix", using: :btree
  add_index "mdl_assignfeedback_editpdf_annot", ["gradeid"], name: "mdl_assieditanno_gra_ix", using: :btree

  create_table "mdl_assignfeedback_editpdf_cmnt", force: true do |t|
    t.integer "gradeid", limit: 8,          default: 0,       null: false
    t.integer "x",       limit: 8,          default: 0
    t.integer "y",       limit: 8,          default: 0
    t.integer "width",   limit: 8,          default: 120
    t.text    "rawtext", limit: 2147483647
    t.integer "pageno",  limit: 8,          default: 0,       null: false
    t.string  "colour",  limit: 10,         default: "black"
    t.integer "draft",   limit: 1,          default: 1,       null: false
  end

  add_index "mdl_assignfeedback_editpdf_cmnt", ["gradeid", "pageno"], name: "mdl_assieditcmnt_grapag_ix", using: :btree
  add_index "mdl_assignfeedback_editpdf_cmnt", ["gradeid"], name: "mdl_assieditcmnt_gra_ix", using: :btree

  create_table "mdl_assignfeedback_editpdf_quick", force: true do |t|
    t.integer "userid",  limit: 8,          default: 0,        null: false
    t.text    "rawtext", limit: 2147483647,                    null: false
    t.integer "width",   limit: 8,          default: 120,      null: false
    t.string  "colour",  limit: 10,         default: "yellow"
  end

  add_index "mdl_assignfeedback_editpdf_quick", ["userid"], name: "mdl_assieditquic_use_ix", using: :btree

  create_table "mdl_assignfeedback_file", force: true do |t|
    t.integer "assignment", limit: 8, default: 0, null: false
    t.integer "grade",      limit: 8, default: 0, null: false
    t.integer "numfiles",   limit: 8, default: 0, null: false
  end

  add_index "mdl_assignfeedback_file", ["assignment"], name: "mdl_assifile_ass2_ix", using: :btree
  add_index "mdl_assignfeedback_file", ["grade"], name: "mdl_assifile_gra_ix", using: :btree

  create_table "mdl_assignment", force: true do |t|
    t.integer "course",         limit: 8,          default: 0,      null: false
    t.string  "name",                              default: "",     null: false
    t.text    "intro",          limit: 2147483647,                  null: false
    t.integer "introformat",    limit: 2,          default: 0,      null: false
    t.string  "assignmenttype", limit: 50,         default: "",     null: false
    t.integer "resubmit",       limit: 1,          default: 0,      null: false
    t.integer "preventlate",    limit: 1,          default: 0,      null: false
    t.integer "emailteachers",  limit: 1,          default: 0,      null: false
    t.integer "var1",           limit: 8,          default: 0
    t.integer "var2",           limit: 8,          default: 0
    t.integer "var3",           limit: 8,          default: 0
    t.integer "var4",           limit: 8,          default: 0
    t.integer "var5",           limit: 8,          default: 0
    t.integer "maxbytes",       limit: 8,          default: 100000, null: false
    t.integer "timedue",        limit: 8,          default: 0,      null: false
    t.integer "timeavailable",  limit: 8,          default: 0,      null: false
    t.integer "grade",          limit: 8,          default: 0,      null: false
    t.integer "timemodified",   limit: 8,          default: 0,      null: false
  end

  add_index "mdl_assignment", ["course"], name: "mdl_assi_cou_ix", using: :btree

  create_table "mdl_assignment_submissions", force: true do |t|
    t.integer "assignment",        limit: 8,          default: 0,     null: false
    t.integer "userid",            limit: 8,          default: 0,     null: false
    t.integer "timecreated",       limit: 8,          default: 0,     null: false
    t.integer "timemodified",      limit: 8,          default: 0,     null: false
    t.integer "numfiles",          limit: 8,          default: 0,     null: false
    t.text    "data1",             limit: 2147483647
    t.text    "data2",             limit: 2147483647
    t.integer "grade",             limit: 8,          default: 0,     null: false
    t.text    "submissioncomment", limit: 2147483647,                 null: false
    t.integer "format",            limit: 2,          default: 0,     null: false
    t.integer "teacher",           limit: 8,          default: 0,     null: false
    t.integer "timemarked",        limit: 8,          default: 0,     null: false
    t.boolean "mailed",                               default: false, null: false
  end

  add_index "mdl_assignment_submissions", ["assignment"], name: "mdl_assisubm_ass_ix", using: :btree
  add_index "mdl_assignment_submissions", ["mailed"], name: "mdl_assisubm_mai_ix", using: :btree
  add_index "mdl_assignment_submissions", ["timemarked"], name: "mdl_assisubm_tim_ix", using: :btree
  add_index "mdl_assignment_submissions", ["userid"], name: "mdl_assisubm_use_ix", using: :btree

  create_table "mdl_assignsubmission_file", force: true do |t|
    t.integer "assignment", limit: 8, default: 0, null: false
    t.integer "submission", limit: 8, default: 0, null: false
    t.integer "numfiles",   limit: 8, default: 0, null: false
  end

  add_index "mdl_assignsubmission_file", ["assignment"], name: "mdl_assifile_ass_ix", using: :btree
  add_index "mdl_assignsubmission_file", ["submission"], name: "mdl_assifile_sub_ix", using: :btree

  create_table "mdl_assignsubmission_onlinetext", force: true do |t|
    t.integer "assignment",   limit: 8,          default: 0, null: false
    t.integer "submission",   limit: 8,          default: 0, null: false
    t.text    "onlinetext",   limit: 2147483647
    t.integer "onlineformat", limit: 2,          default: 0, null: false
  end

  add_index "mdl_assignsubmission_onlinetext", ["assignment"], name: "mdl_assionli_ass_ix", using: :btree
  add_index "mdl_assignsubmission_onlinetext", ["submission"], name: "mdl_assionli_sub_ix", using: :btree

  create_table "mdl_attendance_log", force: true do |t|
    t.integer "sessionid",   limit: 8,   default: 0, null: false
    t.integer "studentid",   limit: 8,   default: 0, null: false
    t.integer "statusid",    limit: 8,   default: 0, null: false
    t.string  "statusset",   limit: 100
    t.integer "inclasswork", limit: 8,   default: 0, null: false
    t.integer "attitude",    limit: 8,   default: 0, null: false
    t.integer "timetaken",   limit: 8,   default: 0, null: false
    t.integer "takenby",     limit: 8,   default: 0, null: false
    t.string  "remarks"
  end

  add_index "mdl_attendance_log", ["sessionid"], name: "mdl_attelog_ses_ix", using: :btree
  add_index "mdl_attendance_log", ["statusid"], name: "mdl_attelog_sta_ix", using: :btree
  add_index "mdl_attendance_log", ["studentid"], name: "mdl_attelog_stu_ix", using: :btree

  create_table "mdl_attendance_sessions", force: true do |t|
    t.integer "groupid",           limit: 8,          default: 0, null: false
    t.integer "attendanceid",      limit: 8,          default: 0, null: false
    t.integer "sessdate",          limit: 8,          default: 0, null: false
    t.integer "duration",          limit: 8,          default: 0, null: false
    t.integer "lasttaken",         limit: 8
    t.integer "lasttakenby",       limit: 8,          default: 0, null: false
    t.integer "timemodified",      limit: 8
    t.text    "description",       limit: 2147483647,             null: false
    t.integer "descriptionformat", limit: 2,          default: 0, null: false
    t.integer "pagenum",           limit: 8,          default: 0, null: false
  end

  add_index "mdl_attendance_sessions", ["attendanceid"], name: "mdl_attesess_att_ix", using: :btree
  add_index "mdl_attendance_sessions", ["groupid"], name: "mdl_attesess_gro_ix", using: :btree
  add_index "mdl_attendance_sessions", ["sessdate"], name: "mdl_attesess_ses_ix", using: :btree

  create_table "mdl_attendance_statuses", force: true do |t|
    t.integer "attendanceid", limit: 8,  default: 0,     null: false
    t.string  "acronym",      limit: 2,  default: "",    null: false
    t.string  "description",  limit: 30, default: "",    null: false
    t.integer "grade",        limit: 2,  default: 0,     null: false
    t.boolean "visible",                 default: true,  null: false
    t.boolean "deleted",                 default: false, null: false
  end

  add_index "mdl_attendance_statuses", ["attendanceid"], name: "mdl_attestat_att_ix", using: :btree
  add_index "mdl_attendance_statuses", ["deleted"], name: "mdl_attestat_del_ix", using: :btree
  add_index "mdl_attendance_statuses", ["visible"], name: "mdl_attestat_vis_ix", using: :btree

  create_table "mdl_attforblock", force: true do |t|
    t.integer "course", limit: 8, default: 0,   null: false
    t.string  "name"
    t.integer "grade",  limit: 8, default: 100, null: false
  end

  add_index "mdl_attforblock", ["course"], name: "mdl_attf_cou_ix", using: :btree

  create_table "mdl_backup_controllers", force: true do |t|
    t.string  "backupid",      limit: 32,         default: "",       null: false
    t.string  "operation",     limit: 20,         default: "backup", null: false
    t.string  "type",          limit: 10,         default: "",       null: false
    t.integer "itemid",        limit: 8,                             null: false
    t.string  "format",        limit: 20,         default: "",       null: false
    t.integer "interactive",   limit: 2,                             null: false
    t.integer "purpose",       limit: 2,                             null: false
    t.integer "userid",        limit: 8,                             null: false
    t.integer "status",        limit: 2,                             null: false
    t.integer "execution",     limit: 2,                             null: false
    t.integer "executiontime", limit: 8,                             null: false
    t.string  "checksum",      limit: 32,         default: "",       null: false
    t.integer "timecreated",   limit: 8,                             null: false
    t.integer "timemodified",  limit: 8,                             null: false
    t.text    "controller",    limit: 2147483647,                    null: false
  end

  add_index "mdl_backup_controllers", ["backupid"], name: "mdl_backcont_bac_uix", unique: true, using: :btree
  add_index "mdl_backup_controllers", ["type", "itemid"], name: "mdl_backcont_typite2_ix", using: :btree
  add_index "mdl_backup_controllers", ["userid"], name: "mdl_backcont_use_ix", using: :btree

  create_table "mdl_backup_courses", force: true do |t|
    t.integer "courseid",      limit: 8, default: 0,   null: false
    t.integer "laststarttime", limit: 8, default: 0,   null: false
    t.integer "lastendtime",   limit: 8, default: 0,   null: false
    t.string  "laststatus",    limit: 1, default: "5", null: false
    t.integer "nextstarttime", limit: 8, default: 0,   null: false
  end

  add_index "mdl_backup_courses", ["courseid"], name: "mdl_backcour_cou_uix", unique: true, using: :btree

  create_table "mdl_backup_logs", force: true do |t|
    t.string  "backupid",    limit: 32,         default: "", null: false
    t.integer "loglevel",    limit: 2,                       null: false
    t.text    "message",     limit: 2147483647,              null: false
    t.integer "timecreated", limit: 8,                       null: false
  end

  add_index "mdl_backup_logs", ["backupid", "id"], name: "mdl_backlogs_bacid_uix", unique: true, using: :btree
  add_index "mdl_backup_logs", ["backupid"], name: "mdl_backlogs_bac_ix", using: :btree

  create_table "mdl_badge", force: true do |t|
    t.string  "name",                              default: "",    null: false
    t.text    "description",    limit: 2147483647
    t.integer "timecreated",    limit: 8,          default: 0,     null: false
    t.integer "timemodified",   limit: 8,          default: 0,     null: false
    t.integer "usercreated",    limit: 8,                          null: false
    t.integer "usermodified",   limit: 8,                          null: false
    t.string  "issuername",                        default: "",    null: false
    t.string  "issuerurl",                         default: "",    null: false
    t.string  "issuercontact"
    t.integer "expiredate",     limit: 8
    t.integer "expireperiod",   limit: 8
    t.boolean "type",                              default: true,  null: false
    t.integer "courseid",       limit: 8
    t.text    "message",        limit: 2147483647,                 null: false
    t.text    "messagesubject", limit: 2147483647,                 null: false
    t.boolean "attachment",                        default: true,  null: false
    t.boolean "notification",                      default: true,  null: false
    t.boolean "status",                            default: false, null: false
    t.integer "nextcron",       limit: 8
  end

  add_index "mdl_badge", ["courseid"], name: "mdl_badg_cou_ix", using: :btree
  add_index "mdl_badge", ["type"], name: "mdl_badg_typ_ix", using: :btree
  add_index "mdl_badge", ["usercreated"], name: "mdl_badg_use2_ix", using: :btree
  add_index "mdl_badge", ["usermodified"], name: "mdl_badg_use_ix", using: :btree

  create_table "mdl_badge_backpack", force: true do |t|
    t.integer "userid",      limit: 8,   default: 0,     null: false
    t.string  "email",       limit: 100, default: "",    null: false
    t.string  "backpackurl",             default: "",    null: false
    t.integer "backpackuid", limit: 8,                   null: false
    t.boolean "autosync",                default: false, null: false
    t.string  "password",    limit: 50
  end

  add_index "mdl_badge_backpack", ["userid"], name: "mdl_badgback_use_ix", using: :btree

  create_table "mdl_badge_criteria", force: true do |t|
    t.integer "badgeid",      limit: 8, default: 0,    null: false
    t.integer "criteriatype", limit: 8
    t.boolean "method",                 default: true, null: false
  end

  add_index "mdl_badge_criteria", ["badgeid", "criteriatype"], name: "mdl_badgcrit_badcri_uix", unique: true, using: :btree
  add_index "mdl_badge_criteria", ["badgeid"], name: "mdl_badgcrit_bad_ix", using: :btree
  add_index "mdl_badge_criteria", ["criteriatype"], name: "mdl_badgcrit_cri_ix", using: :btree

  create_table "mdl_badge_criteria_met", force: true do |t|
    t.integer "issuedid", limit: 8
    t.integer "critid",   limit: 8, null: false
    t.integer "userid",   limit: 8, null: false
    t.integer "datemet",  limit: 8, null: false
  end

  add_index "mdl_badge_criteria_met", ["critid"], name: "mdl_badgcritmet_cri_ix", using: :btree
  add_index "mdl_badge_criteria_met", ["issuedid"], name: "mdl_badgcritmet_iss_ix", using: :btree
  add_index "mdl_badge_criteria_met", ["userid"], name: "mdl_badgcritmet_use_ix", using: :btree

  create_table "mdl_badge_criteria_param", force: true do |t|
    t.integer "critid", limit: 8,              null: false
    t.string  "name",             default: "", null: false
    t.string  "value"
  end

  add_index "mdl_badge_criteria_param", ["critid"], name: "mdl_badgcritpara_cri_ix", using: :btree

  create_table "mdl_badge_external", force: true do |t|
    t.integer "backpackid",   limit: 8, null: false
    t.integer "collectionid", limit: 8, null: false
  end

  add_index "mdl_badge_external", ["backpackid"], name: "mdl_badgexte_bac_ix", using: :btree

  create_table "mdl_badge_issued", force: true do |t|
    t.integer "badgeid",        limit: 8,          default: 0,     null: false
    t.integer "userid",         limit: 8,          default: 0,     null: false
    t.text    "uniquehash",     limit: 2147483647,                 null: false
    t.integer "dateissued",     limit: 8,          default: 0,     null: false
    t.integer "dateexpire",     limit: 8
    t.boolean "visible",                           default: false, null: false
    t.integer "issuernotified", limit: 8
  end

  add_index "mdl_badge_issued", ["badgeid", "userid"], name: "mdl_badgissu_baduse_uix", unique: true, using: :btree
  add_index "mdl_badge_issued", ["badgeid"], name: "mdl_badgissu_bad_ix", using: :btree
  add_index "mdl_badge_issued", ["userid"], name: "mdl_badgissu_use_ix", using: :btree

  create_table "mdl_badge_manual_award", force: true do |t|
    t.integer "badgeid",     limit: 8, null: false
    t.integer "recipientid", limit: 8, null: false
    t.integer "issuerid",    limit: 8, null: false
    t.integer "issuerrole",  limit: 8, null: false
    t.integer "datemet",     limit: 8, null: false
  end

  add_index "mdl_badge_manual_award", ["badgeid"], name: "mdl_badgmanuawar_bad_ix", using: :btree
  add_index "mdl_badge_manual_award", ["issuerid"], name: "mdl_badgmanuawar_iss_ix", using: :btree
  add_index "mdl_badge_manual_award", ["issuerrole"], name: "mdl_badgmanuawar_iss2_ix", using: :btree
  add_index "mdl_badge_manual_award", ["recipientid"], name: "mdl_badgmanuawar_rec_ix", using: :btree

  create_table "mdl_block", force: true do |t|
    t.string  "name",     limit: 40, default: "",   null: false
    t.integer "cron",     limit: 8,  default: 0,    null: false
    t.integer "lastcron", limit: 8,  default: 0,    null: false
    t.boolean "visible",             default: true, null: false
  end

  add_index "mdl_block", ["name"], name: "mdl_bloc_nam_uix", unique: true, using: :btree

  create_table "mdl_block_community", force: true do |t|
    t.integer "userid",            limit: 8,                       null: false
    t.string  "coursename",                           default: "", null: false
    t.text    "coursedescription", limit: 2147483647
    t.string  "courseurl",                            default: "", null: false
    t.string  "imageurl",                             default: "", null: false
  end

  create_table "mdl_block_instances", force: true do |t|
    t.string  "blockname",         limit: 40,         default: "", null: false
    t.integer "parentcontextid",   limit: 8,                       null: false
    t.integer "showinsubcontexts", limit: 2,                       null: false
    t.string  "pagetypepattern",   limit: 64,         default: "", null: false
    t.string  "subpagepattern",    limit: 16
    t.integer "defaultweight",     limit: 8,                       null: false
    t.text    "configdata",        limit: 2147483647
    t.string  "defaultregion",     limit: 16,         default: "", null: false
  end

  add_index "mdl_block_instances", ["parentcontextid", "showinsubcontexts", "pagetypepattern", "subpagepattern"], name: "mdl_blocinst_parshopagsub_ix", using: :btree

  create_table "mdl_block_positions", force: true do |t|
    t.integer "blockinstanceid", limit: 8,               null: false
    t.integer "contextid",       limit: 8,               null: false
    t.string  "pagetype",        limit: 64, default: "", null: false
    t.string  "subpage",         limit: 16, default: "", null: false
    t.integer "visible",         limit: 2,               null: false
    t.string  "region",          limit: 16, default: "", null: false
    t.integer "weight",          limit: 8,               null: false
  end

  add_index "mdl_block_positions", ["blockinstanceid", "contextid", "pagetype", "subpage"], name: "mdl_blocposi_bloconpagsub_uix", unique: true, using: :btree
  add_index "mdl_block_positions", ["blockinstanceid"], name: "mdl_blocposi_blo_ix", using: :btree
  add_index "mdl_block_positions", ["contextid"], name: "mdl_blocposi_con_ix", using: :btree

  create_table "mdl_block_rss_client", force: true do |t|
    t.integer "userid",         limit: 8,          default: 0,  null: false
    t.text    "title",          limit: 2147483647,              null: false
    t.string  "preferredtitle", limit: 64,         default: "", null: false
    t.text    "description",    limit: 2147483647,              null: false
    t.integer "shared",         limit: 1,          default: 0,  null: false
    t.string  "url",                               default: "", null: false
  end

  create_table "mdl_blog_association", force: true do |t|
    t.integer "contextid", limit: 8, null: false
    t.integer "blogid",    limit: 8, null: false
  end

  add_index "mdl_blog_association", ["blogid"], name: "mdl_blogasso_blo_ix", using: :btree
  add_index "mdl_blog_association", ["contextid"], name: "mdl_blogasso_con_ix", using: :btree

  create_table "mdl_blog_external", force: true do |t|
    t.integer "userid",         limit: 8,                          null: false
    t.string  "name",                              default: "",    null: false
    t.text    "description",    limit: 2147483647
    t.text    "url",            limit: 2147483647,                 null: false
    t.string  "filtertags"
    t.boolean "failedlastsync",                    default: false, null: false
    t.integer "timemodified",   limit: 8
    t.integer "timefetched",    limit: 8,          default: 0,     null: false
  end

  add_index "mdl_blog_external", ["userid"], name: "mdl_blogexte_use_ix", using: :btree

  create_table "mdl_book", force: true do |t|
    t.integer "course",       limit: 8,          default: 0,  null: false
    t.string  "name",                            default: "", null: false
    t.text    "intro",        limit: 2147483647
    t.integer "introformat",  limit: 2,          default: 0,  null: false
    t.integer "numbering",    limit: 2,          default: 0,  null: false
    t.integer "customtitles", limit: 1,          default: 0,  null: false
    t.integer "revision",     limit: 8,          default: 0,  null: false
    t.integer "timecreated",  limit: 8,          default: 0,  null: false
    t.integer "timemodified", limit: 8,          default: 0,  null: false
  end

  create_table "mdl_book_chapters", force: true do |t|
    t.integer "bookid",        limit: 8,          default: 0,  null: false
    t.integer "pagenum",       limit: 8,          default: 0,  null: false
    t.integer "subchapter",    limit: 8,          default: 0,  null: false
    t.string  "title",                            default: "", null: false
    t.text    "content",       limit: 2147483647,              null: false
    t.integer "contentformat", limit: 2,          default: 0,  null: false
    t.integer "hidden",        limit: 1,          default: 0,  null: false
    t.integer "timecreated",   limit: 8,          default: 0,  null: false
    t.integer "timemodified",  limit: 8,          default: 0,  null: false
    t.string  "importsrc",                        default: "", null: false
  end

  create_table "mdl_cache_filters", force: true do |t|
    t.string  "filter",       limit: 32,         default: "", null: false
    t.integer "version",      limit: 8,          default: 0,  null: false
    t.string  "md5key",       limit: 32,         default: "", null: false
    t.text    "rawtext",      limit: 2147483647,              null: false
    t.integer "timemodified", limit: 8,          default: 0,  null: false
  end

  add_index "mdl_cache_filters", ["filter", "md5key"], name: "mdl_cachfilt_filmd5_ix", using: :btree

  create_table "mdl_cache_flags", force: true do |t|
    t.string  "flagtype",                        default: "", null: false
    t.string  "name",                            default: "", null: false
    t.integer "timemodified", limit: 8,          default: 0,  null: false
    t.text    "value",        limit: 2147483647,              null: false
    t.integer "expiry",       limit: 8,                       null: false
  end

  add_index "mdl_cache_flags", ["flagtype"], name: "mdl_cachflag_fla_ix", using: :btree
  add_index "mdl_cache_flags", ["name"], name: "mdl_cachflag_nam_ix", using: :btree

  create_table "mdl_cache_text", force: true do |t|
    t.string  "md5key",        limit: 32,         default: "", null: false
    t.text    "formattedtext", limit: 2147483647,              null: false
    t.integer "timemodified",  limit: 8,          default: 0,  null: false
  end

  add_index "mdl_cache_text", ["md5key"], name: "mdl_cachtext_md5_ix", using: :btree
  add_index "mdl_cache_text", ["timemodified"], name: "mdl_cachtext_tim_ix", using: :btree

  create_table "mdl_capabilities", force: true do |t|
    t.string  "name",                     default: "", null: false
    t.string  "captype",      limit: 50,  default: "", null: false
    t.integer "contextlevel", limit: 8,   default: 0,  null: false
    t.string  "component",    limit: 100, default: "", null: false
    t.integer "riskbitmask",  limit: 8,   default: 0,  null: false
  end

  add_index "mdl_capabilities", ["name"], name: "mdl_capa_nam_uix", unique: true, using: :btree

  create_table "mdl_chat", force: true do |t|
    t.integer "course",       limit: 8,          default: 0,  null: false
    t.string  "name",                            default: "", null: false
    t.text    "intro",        limit: 2147483647,              null: false
    t.integer "introformat",  limit: 2,          default: 0,  null: false
    t.integer "keepdays",     limit: 8,          default: 0,  null: false
    t.integer "studentlogs",  limit: 2,          default: 0,  null: false
    t.integer "chattime",     limit: 8,          default: 0,  null: false
    t.integer "schedule",     limit: 2,          default: 0,  null: false
    t.integer "timemodified", limit: 8,          default: 0,  null: false
  end

  add_index "mdl_chat", ["course"], name: "mdl_chat_cou_ix", using: :btree

  create_table "mdl_chat_messages", force: true do |t|
    t.integer "chatid",    limit: 8,          default: 0,     null: false
    t.integer "userid",    limit: 8,          default: 0,     null: false
    t.integer "groupid",   limit: 8,          default: 0,     null: false
    t.boolean "system",                       default: false, null: false
    t.text    "message",   limit: 2147483647,                 null: false
    t.integer "timestamp", limit: 8,          default: 0,     null: false
  end

  add_index "mdl_chat_messages", ["chatid"], name: "mdl_chatmess_cha_ix", using: :btree
  add_index "mdl_chat_messages", ["groupid"], name: "mdl_chatmess_gro_ix", using: :btree
  add_index "mdl_chat_messages", ["timestamp", "chatid"], name: "mdl_chatmess_timcha_ix", using: :btree
  add_index "mdl_chat_messages", ["userid"], name: "mdl_chatmess_use_ix", using: :btree

  create_table "mdl_chat_messages_current", force: true do |t|
    t.integer "chatid",    limit: 8,          default: 0,     null: false
    t.integer "userid",    limit: 8,          default: 0,     null: false
    t.integer "groupid",   limit: 8,          default: 0,     null: false
    t.boolean "system",                       default: false, null: false
    t.text    "message",   limit: 2147483647,                 null: false
    t.integer "timestamp", limit: 8,          default: 0,     null: false
  end

  add_index "mdl_chat_messages_current", ["chatid"], name: "mdl_chatmesscurr_cha_ix", using: :btree
  add_index "mdl_chat_messages_current", ["groupid"], name: "mdl_chatmesscurr_gro_ix", using: :btree
  add_index "mdl_chat_messages_current", ["timestamp", "chatid"], name: "mdl_chatmesscurr_timcha_ix", using: :btree
  add_index "mdl_chat_messages_current", ["userid"], name: "mdl_chatmesscurr_use_ix", using: :btree

  create_table "mdl_chat_users", force: true do |t|
    t.integer "chatid",          limit: 8,  default: 0,  null: false
    t.integer "userid",          limit: 8,  default: 0,  null: false
    t.integer "groupid",         limit: 8,  default: 0,  null: false
    t.string  "version",         limit: 16, default: "", null: false
    t.string  "ip",              limit: 45, default: "", null: false
    t.integer "firstping",       limit: 8,  default: 0,  null: false
    t.integer "lastping",        limit: 8,  default: 0,  null: false
    t.integer "lastmessageping", limit: 8,  default: 0,  null: false
    t.string  "sid",             limit: 32, default: "", null: false
    t.integer "course",          limit: 8,  default: 0,  null: false
    t.string  "lang",            limit: 30, default: "", null: false
  end

  add_index "mdl_chat_users", ["chatid"], name: "mdl_chatuser_cha_ix", using: :btree
  add_index "mdl_chat_users", ["groupid"], name: "mdl_chatuser_gro_ix", using: :btree
  add_index "mdl_chat_users", ["lastping"], name: "mdl_chatuser_las_ix", using: :btree
  add_index "mdl_chat_users", ["userid"], name: "mdl_chatuser_use_ix", using: :btree

  create_table "mdl_choice", force: true do |t|
    t.integer "course",           limit: 8,          default: 0,     null: false
    t.string  "name",                                default: "",    null: false
    t.text    "intro",            limit: 2147483647,                 null: false
    t.integer "introformat",      limit: 2,          default: 0,     null: false
    t.integer "publish",          limit: 1,          default: 0,     null: false
    t.integer "showresults",      limit: 1,          default: 0,     null: false
    t.integer "display",          limit: 2,          default: 0,     null: false
    t.integer "allowupdate",      limit: 1,          default: 0,     null: false
    t.integer "showunanswered",   limit: 1,          default: 0,     null: false
    t.integer "limitanswers",     limit: 1,          default: 0,     null: false
    t.integer "timeopen",         limit: 8,          default: 0,     null: false
    t.integer "timeclose",        limit: 8,          default: 0,     null: false
    t.integer "timemodified",     limit: 8,          default: 0,     null: false
    t.boolean "completionsubmit",                    default: false, null: false
  end

  add_index "mdl_choice", ["course"], name: "mdl_choi_cou_ix", using: :btree

  create_table "mdl_choice_answers", force: true do |t|
    t.integer "choiceid",     limit: 8, default: 0, null: false
    t.integer "userid",       limit: 8, default: 0, null: false
    t.integer "optionid",     limit: 8, default: 0, null: false
    t.integer "timemodified", limit: 8, default: 0, null: false
  end

  add_index "mdl_choice_answers", ["choiceid"], name: "mdl_choiansw_cho_ix", using: :btree
  add_index "mdl_choice_answers", ["optionid"], name: "mdl_choiansw_opt_ix", using: :btree
  add_index "mdl_choice_answers", ["userid"], name: "mdl_choiansw_use_ix", using: :btree

  create_table "mdl_choice_options", force: true do |t|
    t.integer "choiceid",     limit: 8,          default: 0, null: false
    t.text    "text",         limit: 2147483647
    t.integer "maxanswers",   limit: 8,          default: 0
    t.integer "timemodified", limit: 8,          default: 0, null: false
  end

  add_index "mdl_choice_options", ["choiceid"], name: "mdl_choiopti_cho_ix", using: :btree

  create_table "mdl_cohort", force: true do |t|
    t.integer "contextid",         limit: 8,                       null: false
    t.string  "name",              limit: 254,        default: "", null: false
    t.string  "idnumber",          limit: 100
    t.text    "description",       limit: 2147483647
    t.integer "descriptionformat", limit: 1,                       null: false
    t.string  "component",         limit: 100,        default: "", null: false
    t.integer "timecreated",       limit: 8,                       null: false
    t.integer "timemodified",      limit: 8,                       null: false
  end

  add_index "mdl_cohort", ["contextid"], name: "mdl_coho_con_ix", using: :btree

  create_table "mdl_cohort_members", force: true do |t|
    t.integer "cohortid",  limit: 8, default: 0, null: false
    t.integer "userid",    limit: 8, default: 0, null: false
    t.integer "timeadded", limit: 8, default: 0, null: false
  end

  add_index "mdl_cohort_members", ["cohortid", "userid"], name: "mdl_cohomemb_cohuse_uix", unique: true, using: :btree
  add_index "mdl_cohort_members", ["cohortid"], name: "mdl_cohomemb_coh_ix", using: :btree
  add_index "mdl_cohort_members", ["userid"], name: "mdl_cohomemb_use_ix", using: :btree

  create_table "mdl_comments", force: true do |t|
    t.integer "contextid",   limit: 8,                       null: false
    t.string  "commentarea",                    default: "", null: false
    t.integer "itemid",      limit: 8,                       null: false
    t.text    "content",     limit: 2147483647,              null: false
    t.integer "format",      limit: 1,          default: 0,  null: false
    t.integer "userid",      limit: 8,                       null: false
    t.integer "timecreated", limit: 8,                       null: false
  end

  create_table "mdl_config", force: true do |t|
    t.string "name",                     default: "", null: false
    t.text   "value", limit: 2147483647,              null: false
  end

  add_index "mdl_config", ["name"], name: "mdl_conf_nam_uix", unique: true, using: :btree

  create_table "mdl_config_log", force: true do |t|
    t.integer "userid",       limit: 8,                       null: false
    t.integer "timemodified", limit: 8,                       null: false
    t.string  "plugin",       limit: 100
    t.string  "name",         limit: 100,        default: "", null: false
    t.text    "value",        limit: 2147483647
    t.text    "oldvalue",     limit: 2147483647
  end

  add_index "mdl_config_log", ["timemodified"], name: "mdl_conflog_tim_ix", using: :btree
  add_index "mdl_config_log", ["userid"], name: "mdl_conflog_use_ix", using: :btree

  create_table "mdl_config_plugins", force: true do |t|
    t.string "plugin", limit: 100,        default: "core", null: false
    t.string "name",   limit: 100,        default: "",     null: false
    t.text   "value",  limit: 2147483647,                  null: false
  end

  add_index "mdl_config_plugins", ["plugin", "name"], name: "mdl_confplug_plunam_uix", unique: true, using: :btree

  create_table "mdl_context", force: true do |t|
    t.integer "contextlevel", limit: 8, default: 0, null: false
    t.integer "instanceid",   limit: 8, default: 0, null: false
    t.string  "path"
    t.integer "depth",        limit: 1, default: 0, null: false
  end

  add_index "mdl_context", ["contextlevel", "instanceid"], name: "mdl_cont_conins_uix", unique: true, using: :btree
  add_index "mdl_context", ["instanceid"], name: "mdl_cont_ins_ix", using: :btree
  add_index "mdl_context", ["path"], name: "mdl_cont_pat_ix", using: :btree

  create_table "mdl_context_temp", force: true do |t|
    t.string  "path",            default: "", null: false
    t.integer "depth", limit: 1,              null: false
  end

  create_table "mdl_course", force: true do |t|
    t.integer "category",          limit: 8,          default: 0,        null: false
    t.integer "sortorder",         limit: 8,          default: 0,        null: false
    t.string  "fullname",          limit: 254,        default: "",       null: false
    t.string  "shortname",                            default: "",       null: false
    t.string  "idnumber",          limit: 100,        default: "",       null: false
    t.text    "summary",           limit: 2147483647
    t.integer "summaryformat",     limit: 1,          default: 0,        null: false
    t.string  "format",            limit: 21,         default: "topics", null: false
    t.integer "showgrades",        limit: 1,          default: 1,        null: false
    t.integer "newsitems",         limit: 3,          default: 1,        null: false
    t.integer "startdate",         limit: 8,          default: 0,        null: false
    t.integer "marker",            limit: 8,          default: 0,        null: false
    t.integer "maxbytes",          limit: 8,          default: 0,        null: false
    t.integer "legacyfiles",       limit: 2,          default: 0,        null: false
    t.integer "showreports",       limit: 2,          default: 0,        null: false
    t.boolean "visible",                              default: true,     null: false
    t.boolean "visibleold",                           default: true,     null: false
    t.integer "groupmode",         limit: 2,          default: 0,        null: false
    t.integer "groupmodeforce",    limit: 2,          default: 0,        null: false
    t.integer "defaultgroupingid", limit: 8,          default: 0,        null: false
    t.string  "lang",              limit: 30,         default: "",       null: false
    t.string  "theme",             limit: 50,         default: "",       null: false
    t.integer "timecreated",       limit: 8,          default: 0,        null: false
    t.integer "timemodified",      limit: 8,          default: 0,        null: false
    t.boolean "requested",                            default: false,    null: false
    t.boolean "enablecompletion",                     default: false,    null: false
    t.boolean "completionnotify",                     default: false,    null: false
    t.integer "cacherev",          limit: 8,          default: 0,        null: false
    t.string  "calendartype",      limit: 30,         default: "",       null: false
  end

  add_index "mdl_course", ["category"], name: "mdl_cour_cat_ix", using: :btree
  add_index "mdl_course", ["idnumber"], name: "mdl_cour_idn_ix", using: :btree
  add_index "mdl_course", ["shortname"], name: "mdl_cour_sho_ix", using: :btree
  add_index "mdl_course", ["sortorder"], name: "mdl_cour_sor_ix", using: :btree

  create_table "mdl_course_categories", force: true do |t|
    t.string  "name",                                 default: "",   null: false
    t.string  "idnumber",          limit: 100
    t.text    "description",       limit: 2147483647
    t.integer "descriptionformat", limit: 1,          default: 0,    null: false
    t.integer "parent",            limit: 8,          default: 0,    null: false
    t.integer "sortorder",         limit: 8,          default: 0,    null: false
    t.integer "coursecount",       limit: 8,          default: 0,    null: false
    t.boolean "visible",                              default: true, null: false
    t.boolean "visibleold",                           default: true, null: false
    t.integer "timemodified",      limit: 8,          default: 0,    null: false
    t.integer "depth",             limit: 8,          default: 0,    null: false
    t.string  "path",                                 default: "",   null: false
    t.string  "theme",             limit: 50
  end

  add_index "mdl_course_categories", ["parent"], name: "mdl_courcate_par_ix", using: :btree

  create_table "mdl_course_completion_aggr_methd", force: true do |t|
    t.integer "course",       limit: 8,                          default: 0,     null: false
    t.integer "criteriatype", limit: 8
    t.boolean "method",                                          default: false, null: false
    t.decimal "value",                  precision: 10, scale: 5
  end

  add_index "mdl_course_completion_aggr_methd", ["course", "criteriatype"], name: "mdl_courcompaggrmeth_coucr_uix", unique: true, using: :btree
  add_index "mdl_course_completion_aggr_methd", ["course"], name: "mdl_courcompaggrmeth_cou_ix", using: :btree
  add_index "mdl_course_completion_aggr_methd", ["criteriatype"], name: "mdl_courcompaggrmeth_cri_ix", using: :btree

  create_table "mdl_course_completion_crit_compl", force: true do |t|
    t.integer "userid",        limit: 8,                          default: 0, null: false
    t.integer "course",        limit: 8,                          default: 0, null: false
    t.integer "criteriaid",    limit: 8,                          default: 0, null: false
    t.decimal "gradefinal",              precision: 10, scale: 5
    t.integer "unenroled",     limit: 8
    t.integer "timecompleted", limit: 8
  end

  add_index "mdl_course_completion_crit_compl", ["course"], name: "mdl_courcompcritcomp_cou_ix", using: :btree
  add_index "mdl_course_completion_crit_compl", ["criteriaid"], name: "mdl_courcompcritcomp_cri_ix", using: :btree
  add_index "mdl_course_completion_crit_compl", ["timecompleted"], name: "mdl_courcompcritcomp_tim_ix", using: :btree
  add_index "mdl_course_completion_crit_compl", ["userid", "course", "criteriaid"], name: "mdl_courcompcritcomp_useco_uix", unique: true, using: :btree
  add_index "mdl_course_completion_crit_compl", ["userid"], name: "mdl_courcompcritcomp_use_ix", using: :btree

  create_table "mdl_course_completion_criteria", force: true do |t|
    t.integer "course",         limit: 8,                            default: 0, null: false
    t.integer "criteriatype",   limit: 8,                            default: 0, null: false
    t.string  "module",         limit: 100
    t.integer "moduleinstance", limit: 8
    t.integer "courseinstance", limit: 8
    t.integer "enrolperiod",    limit: 8
    t.integer "timeend",        limit: 8
    t.decimal "gradepass",                  precision: 10, scale: 5
    t.integer "role",           limit: 8
  end

  add_index "mdl_course_completion_criteria", ["course"], name: "mdl_courcompcrit_cou_ix", using: :btree

  create_table "mdl_course_completions", force: true do |t|
    t.integer "userid",        limit: 8, default: 0, null: false
    t.integer "course",        limit: 8, default: 0, null: false
    t.integer "timeenrolled",  limit: 8, default: 0, null: false
    t.integer "timestarted",   limit: 8, default: 0, null: false
    t.integer "timecompleted", limit: 8
    t.integer "reaggregate",   limit: 8, default: 0, null: false
  end

  add_index "mdl_course_completions", ["course"], name: "mdl_courcomp_cou_ix", using: :btree
  add_index "mdl_course_completions", ["timecompleted"], name: "mdl_courcomp_tim_ix", using: :btree
  add_index "mdl_course_completions", ["userid", "course"], name: "mdl_courcomp_usecou_uix", unique: true, using: :btree
  add_index "mdl_course_completions", ["userid"], name: "mdl_courcomp_use_ix", using: :btree

  create_table "mdl_course_format_options", force: true do |t|
    t.integer "courseid",  limit: 8,                       null: false
    t.string  "format",    limit: 21,         default: "", null: false
    t.integer "sectionid", limit: 8,          default: 0,  null: false
    t.string  "name",      limit: 100,        default: "", null: false
    t.text    "value",     limit: 2147483647
  end

  add_index "mdl_course_format_options", ["courseid", "format", "sectionid", "name"], name: "mdl_courformopti_couforsec_uix", unique: true, using: :btree
  add_index "mdl_course_format_options", ["courseid"], name: "mdl_courformopti_cou_ix", using: :btree

  create_table "mdl_course_modules", force: true do |t|
    t.integer "course",                    limit: 8,   default: 0,     null: false
    t.integer "module",                    limit: 8,   default: 0,     null: false
    t.integer "instance",                  limit: 8,   default: 0,     null: false
    t.integer "section",                   limit: 8,   default: 0,     null: false
    t.string  "idnumber",                  limit: 100
    t.integer "added",                     limit: 8,   default: 0,     null: false
    t.integer "score",                     limit: 2,   default: 0,     null: false
    t.integer "indent",                    limit: 3,   default: 0,     null: false
    t.boolean "visible",                               default: true,  null: false
    t.boolean "visibleold",                            default: true,  null: false
    t.integer "groupmode",                 limit: 2,   default: 0,     null: false
    t.integer "groupingid",                limit: 8,   default: 0,     null: false
    t.integer "groupmembersonly",          limit: 2,   default: 0,     null: false
    t.boolean "completion",                            default: false, null: false
    t.integer "completiongradeitemnumber", limit: 8
    t.boolean "completionview",                        default: false, null: false
    t.integer "completionexpected",        limit: 8,   default: 0,     null: false
    t.integer "availablefrom",             limit: 8,   default: 0,     null: false
    t.integer "availableuntil",            limit: 8,   default: 0,     null: false
    t.boolean "showavailability",                      default: false, null: false
    t.boolean "showdescription",                       default: false, null: false
  end

  add_index "mdl_course_modules", ["course"], name: "mdl_courmodu_cou_ix", using: :btree
  add_index "mdl_course_modules", ["groupingid"], name: "mdl_courmodu_gro_ix", using: :btree
  add_index "mdl_course_modules", ["idnumber", "course"], name: "mdl_courmodu_idncou_ix", using: :btree
  add_index "mdl_course_modules", ["instance"], name: "mdl_courmodu_ins_ix", using: :btree
  add_index "mdl_course_modules", ["module"], name: "mdl_courmodu_mod_ix", using: :btree
  add_index "mdl_course_modules", ["visible"], name: "mdl_courmodu_vis_ix", using: :btree

  create_table "mdl_course_modules_avail_fields", force: true do |t|
    t.integer "coursemoduleid", limit: 8,               null: false
    t.string  "userfield",      limit: 50
    t.integer "customfieldid",  limit: 8
    t.string  "operator",       limit: 20, default: "", null: false
    t.string  "value",                     default: "", null: false
  end

  add_index "mdl_course_modules_avail_fields", ["coursemoduleid"], name: "mdl_courmoduavaifiel_cou_ix", using: :btree

  create_table "mdl_course_modules_availability", force: true do |t|
    t.integer "coursemoduleid",     limit: 8,                          null: false
    t.integer "sourcecmid",         limit: 8
    t.boolean "requiredcompletion"
    t.integer "gradeitemid",        limit: 8
    t.decimal "grademin",                     precision: 10, scale: 5
    t.decimal "grademax",                     precision: 10, scale: 5
  end

  add_index "mdl_course_modules_availability", ["coursemoduleid"], name: "mdl_courmoduavai_cou_ix", using: :btree
  add_index "mdl_course_modules_availability", ["gradeitemid"], name: "mdl_courmoduavai_gra_ix", using: :btree
  add_index "mdl_course_modules_availability", ["sourcecmid"], name: "mdl_courmoduavai_sou_ix", using: :btree

  create_table "mdl_course_modules_completion", force: true do |t|
    t.integer "coursemoduleid",  limit: 8, null: false
    t.integer "userid",          limit: 8, null: false
    t.boolean "completionstate",           null: false
    t.boolean "viewed"
    t.integer "timemodified",    limit: 8, null: false
  end

  add_index "mdl_course_modules_completion", ["coursemoduleid"], name: "mdl_courmoducomp_cou_ix", using: :btree
  add_index "mdl_course_modules_completion", ["userid", "coursemoduleid"], name: "mdl_courmoducomp_usecou_uix", unique: true, using: :btree

  create_table "mdl_course_published", force: true do |t|
    t.string  "huburl"
    t.integer "courseid",      limit: 8,                 null: false
    t.integer "timepublished", limit: 8,                 null: false
    t.boolean "enrollable",              default: true,  null: false
    t.integer "hubcourseid",   limit: 8,                 null: false
    t.boolean "status",                  default: false
    t.integer "timechecked",   limit: 8
  end

  create_table "mdl_course_request", force: true do |t|
    t.string  "fullname",      limit: 254,        default: "", null: false
    t.string  "shortname",     limit: 100,        default: "", null: false
    t.text    "summary",       limit: 2147483647,              null: false
    t.integer "summaryformat", limit: 1,          default: 0,  null: false
    t.integer "category",      limit: 8,          default: 0,  null: false
    t.text    "reason",        limit: 2147483647,              null: false
    t.integer "requester",     limit: 8,          default: 0,  null: false
    t.string  "password",      limit: 50,         default: "", null: false
  end

  add_index "mdl_course_request", ["shortname"], name: "mdl_courrequ_sho_ix", using: :btree

  create_table "mdl_course_sections", force: true do |t|
    t.integer "course",           limit: 8,          default: 0,     null: false
    t.integer "section",          limit: 8,          default: 0,     null: false
    t.string  "name"
    t.text    "summary",          limit: 2147483647
    t.integer "summaryformat",    limit: 1,          default: 0,     null: false
    t.text    "sequence",         limit: 2147483647
    t.boolean "visible",                             default: true,  null: false
    t.integer "availablefrom",    limit: 8,          default: 0,     null: false
    t.integer "availableuntil",   limit: 8,          default: 0,     null: false
    t.boolean "showavailability",                    default: false, null: false
    t.integer "groupingid",       limit: 8,          default: 0,     null: false
  end

  add_index "mdl_course_sections", ["course", "section"], name: "mdl_coursect_cousec_uix", unique: true, using: :btree

  create_table "mdl_course_sections_avail_fields", force: true do |t|
    t.integer "coursesectionid", limit: 8,               null: false
    t.string  "userfield",       limit: 50
    t.integer "customfieldid",   limit: 8
    t.string  "operator",        limit: 20, default: "", null: false
    t.string  "value",                      default: "", null: false
  end

  add_index "mdl_course_sections_avail_fields", ["coursesectionid"], name: "mdl_coursectavaifiel_cou_ix", using: :btree

  create_table "mdl_course_sections_availability", force: true do |t|
    t.integer "coursesectionid",    limit: 8,                          null: false
    t.integer "sourcecmid",         limit: 8
    t.boolean "requiredcompletion"
    t.integer "gradeitemid",        limit: 8
    t.decimal "grademin",                     precision: 10, scale: 5
    t.decimal "grademax",                     precision: 10, scale: 5
  end

  add_index "mdl_course_sections_availability", ["coursesectionid"], name: "mdl_coursectavai_cou_ix", using: :btree
  add_index "mdl_course_sections_availability", ["gradeitemid"], name: "mdl_coursectavai_gra_ix", using: :btree
  add_index "mdl_course_sections_availability", ["sourcecmid"], name: "mdl_coursectavai_sou_ix", using: :btree

  create_table "mdl_data", force: true do |t|
    t.integer "course",                limit: 8,          default: 0,  null: false
    t.string  "name",                                     default: "", null: false
    t.text    "intro",                 limit: 2147483647,              null: false
    t.integer "introformat",           limit: 2,          default: 0,  null: false
    t.integer "comments",              limit: 2,          default: 0,  null: false
    t.integer "timeavailablefrom",     limit: 8,          default: 0,  null: false
    t.integer "timeavailableto",       limit: 8,          default: 0,  null: false
    t.integer "timeviewfrom",          limit: 8,          default: 0,  null: false
    t.integer "timeviewto",            limit: 8,          default: 0,  null: false
    t.integer "requiredentries",                          default: 0,  null: false
    t.integer "requiredentriestoview",                    default: 0,  null: false
    t.integer "maxentries",                               default: 0,  null: false
    t.integer "rssarticles",           limit: 2,          default: 0,  null: false
    t.text    "singletemplate",        limit: 2147483647
    t.text    "listtemplate",          limit: 2147483647
    t.text    "listtemplateheader",    limit: 2147483647
    t.text    "listtemplatefooter",    limit: 2147483647
    t.text    "addtemplate",           limit: 2147483647
    t.text    "rsstemplate",           limit: 2147483647
    t.text    "rsstitletemplate",      limit: 2147483647
    t.text    "csstemplate",           limit: 2147483647
    t.text    "jstemplate",            limit: 2147483647
    t.text    "asearchtemplate",       limit: 2147483647
    t.integer "approval",              limit: 2,          default: 0,  null: false
    t.integer "scale",                 limit: 8,          default: 0,  null: false
    t.integer "assessed",              limit: 8,          default: 0,  null: false
    t.integer "assesstimestart",       limit: 8,          default: 0,  null: false
    t.integer "assesstimefinish",      limit: 8,          default: 0,  null: false
    t.integer "defaultsort",           limit: 8,          default: 0,  null: false
    t.integer "defaultsortdir",        limit: 2,          default: 0,  null: false
    t.integer "editany",               limit: 2,          default: 0,  null: false
    t.integer "notification",          limit: 8,          default: 0,  null: false
  end

  add_index "mdl_data", ["course"], name: "mdl_data_cou_ix", using: :btree

  create_table "mdl_data_content", force: true do |t|
    t.integer "fieldid",  limit: 8,          default: 0, null: false
    t.integer "recordid", limit: 8,          default: 0, null: false
    t.text    "content",  limit: 2147483647
    t.text    "content1", limit: 2147483647
    t.text    "content2", limit: 2147483647
    t.text    "content3", limit: 2147483647
    t.text    "content4", limit: 2147483647
  end

  add_index "mdl_data_content", ["fieldid"], name: "mdl_datacont_fie_ix", using: :btree
  add_index "mdl_data_content", ["recordid"], name: "mdl_datacont_rec_ix", using: :btree

  create_table "mdl_data_fields", force: true do |t|
    t.integer "dataid",      limit: 8,          default: 0,  null: false
    t.string  "type",                           default: "", null: false
    t.string  "name",                           default: "", null: false
    t.text    "description", limit: 2147483647,              null: false
    t.text    "param1",      limit: 2147483647
    t.text    "param2",      limit: 2147483647
    t.text    "param3",      limit: 2147483647
    t.text    "param4",      limit: 2147483647
    t.text    "param5",      limit: 2147483647
    t.text    "param6",      limit: 2147483647
    t.text    "param7",      limit: 2147483647
    t.text    "param8",      limit: 2147483647
    t.text    "param9",      limit: 2147483647
    t.text    "param10",     limit: 2147483647
  end

  add_index "mdl_data_fields", ["dataid"], name: "mdl_datafiel_dat_ix", using: :btree
  add_index "mdl_data_fields", ["type", "dataid"], name: "mdl_datafiel_typdat_ix", using: :btree

  create_table "mdl_data_records", force: true do |t|
    t.integer "userid",       limit: 8, default: 0, null: false
    t.integer "groupid",      limit: 8, default: 0, null: false
    t.integer "dataid",       limit: 8, default: 0, null: false
    t.integer "timecreated",  limit: 8, default: 0, null: false
    t.integer "timemodified", limit: 8, default: 0, null: false
    t.integer "approved",     limit: 2, default: 0, null: false
  end

  add_index "mdl_data_records", ["dataid"], name: "mdl_datareco_dat_ix", using: :btree

  create_table "mdl_enrol", force: true do |t|
    t.string  "enrol",           limit: 20,                                  default: "",    null: false
    t.integer "status",          limit: 8,                                   default: 0,     null: false
    t.integer "courseid",        limit: 8,                                                   null: false
    t.integer "sortorder",       limit: 8,                                   default: 0,     null: false
    t.string  "name"
    t.integer "enrolperiod",     limit: 8,                                   default: 0
    t.integer "enrolstartdate",  limit: 8,                                   default: 0
    t.integer "enrolenddate",    limit: 8,                                   default: 0
    t.boolean "expirynotify",                                                default: false
    t.integer "expirythreshold", limit: 8,                                   default: 0
    t.boolean "notifyall",                                                   default: false
    t.string  "password",        limit: 50
    t.string  "cost",            limit: 20
    t.string  "currency",        limit: 3
    t.integer "roleid",          limit: 8,                                   default: 0
    t.integer "customint1",      limit: 8
    t.integer "customint2",      limit: 8
    t.integer "customint3",      limit: 8
    t.integer "customint4",      limit: 8
    t.integer "customint5",      limit: 8
    t.integer "customint6",      limit: 8
    t.integer "customint7",      limit: 8
    t.integer "customint8",      limit: 8
    t.string  "customchar1"
    t.string  "customchar2"
    t.string  "customchar3",     limit: 1333
    t.decimal "customdec1",                         precision: 12, scale: 7
    t.decimal "customdec2",                         precision: 12, scale: 7
    t.text    "customtext1",     limit: 2147483647
    t.text    "customtext2",     limit: 2147483647
    t.text    "customtext3",     limit: 2147483647
    t.text    "customtext4",     limit: 2147483647
    t.integer "timecreated",     limit: 8,                                   default: 0,     null: false
    t.integer "timemodified",    limit: 8,                                   default: 0,     null: false
  end

  add_index "mdl_enrol", ["courseid"], name: "mdl_enro_cou_ix", using: :btree
  add_index "mdl_enrol", ["enrol"], name: "mdl_enro_enr_ix", using: :btree

  create_table "mdl_enrol_flatfile", force: true do |t|
    t.string  "action",       limit: 30, default: "", null: false
    t.integer "roleid",       limit: 8,               null: false
    t.integer "userid",       limit: 8,               null: false
    t.integer "courseid",     limit: 8,               null: false
    t.integer "timestart",    limit: 8,  default: 0,  null: false
    t.integer "timeend",      limit: 8,  default: 0,  null: false
    t.integer "timemodified", limit: 8,  default: 0,  null: false
  end

  add_index "mdl_enrol_flatfile", ["courseid"], name: "mdl_enroflat_cou_ix", using: :btree
  add_index "mdl_enrol_flatfile", ["roleid"], name: "mdl_enroflat_rol_ix", using: :btree
  add_index "mdl_enrol_flatfile", ["userid"], name: "mdl_enroflat_use_ix", using: :btree

  create_table "mdl_enrol_paypal", force: true do |t|
    t.string  "business",                       default: "", null: false
    t.string  "receiver_email",                 default: "", null: false
    t.string  "receiver_id",                    default: "", null: false
    t.string  "item_name",                      default: "", null: false
    t.integer "courseid",            limit: 8,  default: 0,  null: false
    t.integer "userid",              limit: 8,  default: 0,  null: false
    t.integer "instanceid",          limit: 8,  default: 0,  null: false
    t.string  "memo",                           default: "", null: false
    t.string  "tax",                            default: "", null: false
    t.string  "option_name1",                   default: "", null: false
    t.string  "option_selection1_x",            default: "", null: false
    t.string  "option_name2",                   default: "", null: false
    t.string  "option_selection2_x",            default: "", null: false
    t.string  "payment_status",                 default: "", null: false
    t.string  "pending_reason",                 default: "", null: false
    t.string  "reason_code",         limit: 30, default: "", null: false
    t.string  "txn_id",                         default: "", null: false
    t.string  "parent_txn_id",                  default: "", null: false
    t.string  "payment_type",        limit: 30, default: "", null: false
    t.integer "timeupdated",         limit: 8,  default: 0,  null: false
  end

  create_table "mdl_event", force: true do |t|
    t.text    "name",           limit: 2147483647,              null: false
    t.text    "description",    limit: 2147483647,              null: false
    t.integer "format",         limit: 2,          default: 0,  null: false
    t.integer "courseid",       limit: 8,          default: 0,  null: false
    t.integer "groupid",        limit: 8,          default: 0,  null: false
    t.integer "userid",         limit: 8,          default: 0,  null: false
    t.integer "repeatid",       limit: 8,          default: 0,  null: false
    t.string  "modulename",     limit: 20,         default: "", null: false
    t.integer "instance",       limit: 8,          default: 0,  null: false
    t.string  "eventtype",      limit: 20,         default: "", null: false
    t.integer "timestart",      limit: 8,          default: 0,  null: false
    t.integer "timeduration",   limit: 8,          default: 0,  null: false
    t.integer "visible",        limit: 2,          default: 1,  null: false
    t.string  "uuid",                              default: "", null: false
    t.integer "sequence",       limit: 8,          default: 1,  null: false
    t.integer "timemodified",   limit: 8,          default: 0,  null: false
    t.integer "subscriptionid", limit: 8
  end

  add_index "mdl_event", ["courseid"], name: "mdl_even_cou_ix", using: :btree
  add_index "mdl_event", ["groupid", "courseid", "visible", "userid"], name: "mdl_even_grocouvisuse_ix", using: :btree
  add_index "mdl_event", ["timeduration"], name: "mdl_even_tim2_ix", using: :btree
  add_index "mdl_event", ["timestart"], name: "mdl_even_tim_ix", using: :btree
  add_index "mdl_event", ["userid"], name: "mdl_even_use_ix", using: :btree

  create_table "mdl_event_subscriptions", force: true do |t|
    t.string  "url",                     default: "", null: false
    t.integer "courseid",     limit: 8,  default: 0,  null: false
    t.integer "groupid",      limit: 8,  default: 0,  null: false
    t.integer "userid",       limit: 8,  default: 0,  null: false
    t.string  "eventtype",    limit: 20, default: "", null: false
    t.integer "pollinterval", limit: 8,  default: 0,  null: false
    t.integer "lastupdated",  limit: 8
    t.string  "name",                    default: "", null: false
  end

  create_table "mdl_events_handlers", force: true do |t|
    t.string  "eventname",       limit: 166,        default: "", null: false
    t.string  "component",       limit: 166,        default: "", null: false
    t.string  "handlerfile",                        default: "", null: false
    t.text    "handlerfunction", limit: 2147483647
    t.string  "schedule"
    t.integer "status",          limit: 8,          default: 0,  null: false
    t.integer "internal",        limit: 1,          default: 1,  null: false
  end

  add_index "mdl_events_handlers", ["eventname", "component"], name: "mdl_evenhand_evecom_uix", unique: true, using: :btree

  create_table "mdl_events_queue", force: true do |t|
    t.text    "eventdata",   limit: 2147483647, null: false
    t.text    "stackdump",   limit: 2147483647
    t.integer "userid",      limit: 8
    t.integer "timecreated", limit: 8,          null: false
  end

  add_index "mdl_events_queue", ["userid"], name: "mdl_evenqueu_use_ix", using: :btree

  create_table "mdl_events_queue_handlers", force: true do |t|
    t.integer "queuedeventid", limit: 8,          null: false
    t.integer "handlerid",     limit: 8,          null: false
    t.integer "status",        limit: 8
    t.text    "errormessage",  limit: 2147483647
    t.integer "timemodified",  limit: 8,          null: false
  end

  add_index "mdl_events_queue_handlers", ["handlerid"], name: "mdl_evenqueuhand_han_ix", using: :btree
  add_index "mdl_events_queue_handlers", ["queuedeventid"], name: "mdl_evenqueuhand_que_ix", using: :btree

  create_table "mdl_external_functions", force: true do |t|
    t.string "name",         limit: 200, default: "", null: false
    t.string "classname",    limit: 100, default: "", null: false
    t.string "methodname",   limit: 100, default: "", null: false
    t.string "classpath"
    t.string "component",    limit: 100, default: "", null: false
    t.string "capabilities"
  end

  add_index "mdl_external_functions", ["name"], name: "mdl_extefunc_nam_uix", unique: true, using: :btree

  create_table "mdl_external_services", force: true do |t|
    t.string  "name",               limit: 200, default: "",    null: false
    t.boolean "enabled",                                        null: false
    t.string  "requiredcapability", limit: 150
    t.boolean "restrictedusers",                                null: false
    t.string  "component",          limit: 100
    t.integer "timecreated",        limit: 8,                   null: false
    t.integer "timemodified",       limit: 8
    t.string  "shortname"
    t.boolean "downloadfiles",                  default: false, null: false
    t.boolean "uploadfiles",                    default: false, null: false
  end

  add_index "mdl_external_services", ["name"], name: "mdl_exteserv_nam_uix", unique: true, using: :btree

  create_table "mdl_external_services_functions", force: true do |t|
    t.integer "externalserviceid", limit: 8,                null: false
    t.string  "functionname",      limit: 200, default: "", null: false
  end

  add_index "mdl_external_services_functions", ["externalserviceid"], name: "mdl_exteservfunc_ext_ix", using: :btree

  create_table "mdl_external_services_users", force: true do |t|
    t.integer "externalserviceid", limit: 8, null: false
    t.integer "userid",            limit: 8, null: false
    t.string  "iprestriction"
    t.integer "validuntil",        limit: 8
    t.integer "timecreated",       limit: 8
  end

  add_index "mdl_external_services_users", ["externalserviceid"], name: "mdl_exteservuser_ext_ix", using: :btree
  add_index "mdl_external_services_users", ["userid"], name: "mdl_exteservuser_use_ix", using: :btree

  create_table "mdl_external_tokens", force: true do |t|
    t.string  "token",             limit: 128, default: "", null: false
    t.integer "tokentype",         limit: 2,                null: false
    t.integer "userid",            limit: 8,                null: false
    t.integer "externalserviceid", limit: 8,                null: false
    t.string  "sid",               limit: 128
    t.integer "contextid",         limit: 8,                null: false
    t.integer "creatorid",         limit: 8,   default: 1,  null: false
    t.string  "iprestriction"
    t.integer "validuntil",        limit: 8
    t.integer "timecreated",       limit: 8,                null: false
    t.integer "lastaccess",        limit: 8
  end

  add_index "mdl_external_tokens", ["contextid"], name: "mdl_extetoke_con_ix", using: :btree
  add_index "mdl_external_tokens", ["creatorid"], name: "mdl_extetoke_cre_ix", using: :btree
  add_index "mdl_external_tokens", ["externalserviceid"], name: "mdl_extetoke_ext_ix", using: :btree
  add_index "mdl_external_tokens", ["userid"], name: "mdl_extetoke_use_ix", using: :btree

  create_table "mdl_feedback", force: true do |t|
    t.integer "course",                  limit: 8,          default: 0,     null: false
    t.string  "name",                                       default: "",    null: false
    t.text    "intro",                   limit: 2147483647,                 null: false
    t.integer "introformat",             limit: 2,          default: 0,     null: false
    t.boolean "anonymous",                                  default: true,  null: false
    t.boolean "email_notification",                         default: true,  null: false
    t.boolean "multiple_submit",                            default: true,  null: false
    t.boolean "autonumbering",                              default: true,  null: false
    t.string  "site_after_submit",                          default: "",    null: false
    t.text    "page_after_submit",       limit: 2147483647,                 null: false
    t.integer "page_after_submitformat", limit: 1,          default: 0,     null: false
    t.boolean "publish_stats",                              default: false, null: false
    t.integer "timeopen",                limit: 8,          default: 0,     null: false
    t.integer "timeclose",               limit: 8,          default: 0,     null: false
    t.integer "timemodified",            limit: 8,          default: 0,     null: false
    t.boolean "completionsubmit",                           default: false, null: false
  end

  add_index "mdl_feedback", ["course"], name: "mdl_feed_cou_ix", using: :btree

  create_table "mdl_feedback_completed", force: true do |t|
    t.integer "feedback",           limit: 8, default: 0,     null: false
    t.integer "userid",             limit: 8, default: 0,     null: false
    t.integer "timemodified",       limit: 8, default: 0,     null: false
    t.integer "random_response",    limit: 8, default: 0,     null: false
    t.boolean "anonymous_response",           default: false, null: false
  end

  add_index "mdl_feedback_completed", ["feedback"], name: "mdl_feedcomp_fee_ix", using: :btree
  add_index "mdl_feedback_completed", ["userid"], name: "mdl_feedcomp_use_ix", using: :btree

  create_table "mdl_feedback_completedtmp", force: true do |t|
    t.integer "feedback",           limit: 8, default: 0,     null: false
    t.integer "userid",             limit: 8, default: 0,     null: false
    t.string  "guestid",                      default: "",    null: false
    t.integer "timemodified",       limit: 8, default: 0,     null: false
    t.integer "random_response",    limit: 8, default: 0,     null: false
    t.boolean "anonymous_response",           default: false, null: false
  end

  add_index "mdl_feedback_completedtmp", ["feedback"], name: "mdl_feedcomp_fee2_ix", using: :btree
  add_index "mdl_feedback_completedtmp", ["userid"], name: "mdl_feedcomp_use2_ix", using: :btree

  create_table "mdl_feedback_item", force: true do |t|
    t.integer "feedback",     limit: 8,          default: 0,     null: false
    t.integer "template",     limit: 8,          default: 0,     null: false
    t.string  "name",                            default: "",    null: false
    t.string  "label",                           default: "",    null: false
    t.text    "presentation", limit: 2147483647,                 null: false
    t.string  "typ",                             default: "",    null: false
    t.boolean "hasvalue",                        default: false, null: false
    t.integer "position",     limit: 2,          default: 0,     null: false
    t.boolean "required",                        default: false, null: false
    t.integer "dependitem",   limit: 8,          default: 0,     null: false
    t.string  "dependvalue",                     default: "",    null: false
    t.string  "options",                         default: "",    null: false
  end

  add_index "mdl_feedback_item", ["feedback"], name: "mdl_feeditem_fee_ix", using: :btree
  add_index "mdl_feedback_item", ["template"], name: "mdl_feeditem_tem_ix", using: :btree

  create_table "mdl_feedback_sitecourse_map", force: true do |t|
    t.integer "feedbackid", limit: 8, default: 0, null: false
    t.integer "courseid",   limit: 8, default: 0, null: false
  end

  add_index "mdl_feedback_sitecourse_map", ["courseid"], name: "mdl_feedsitemap_cou_ix", using: :btree
  add_index "mdl_feedback_sitecourse_map", ["feedbackid"], name: "mdl_feedsitemap_fee_ix", using: :btree

  create_table "mdl_feedback_template", force: true do |t|
    t.integer "course",   limit: 8, default: 0,     null: false
    t.boolean "ispublic",           default: false, null: false
    t.string  "name",               default: "",    null: false
  end

  add_index "mdl_feedback_template", ["course"], name: "mdl_feedtemp_cou_ix", using: :btree

  create_table "mdl_feedback_tracking", force: true do |t|
    t.integer "userid",        limit: 8, default: 0, null: false
    t.integer "feedback",      limit: 8, default: 0, null: false
    t.integer "completed",     limit: 8, default: 0, null: false
    t.integer "tmp_completed", limit: 8, default: 0, null: false
  end

  add_index "mdl_feedback_tracking", ["completed"], name: "mdl_feedtrac_com_ix", using: :btree
  add_index "mdl_feedback_tracking", ["feedback"], name: "mdl_feedtrac_fee_ix", using: :btree
  add_index "mdl_feedback_tracking", ["userid"], name: "mdl_feedtrac_use_ix", using: :btree

  create_table "mdl_feedback_value", force: true do |t|
    t.integer "course_id",     limit: 8,          default: 0, null: false
    t.integer "item",          limit: 8,          default: 0, null: false
    t.integer "completed",     limit: 8,          default: 0, null: false
    t.integer "tmp_completed", limit: 8,          default: 0, null: false
    t.text    "value",         limit: 2147483647,             null: false
  end

  add_index "mdl_feedback_value", ["course_id"], name: "mdl_feedvalu_cou_ix", using: :btree
  add_index "mdl_feedback_value", ["item"], name: "mdl_feedvalu_ite_ix", using: :btree

  create_table "mdl_feedback_valuetmp", force: true do |t|
    t.integer "course_id",     limit: 8,          default: 0, null: false
    t.integer "item",          limit: 8,          default: 0, null: false
    t.integer "completed",     limit: 8,          default: 0, null: false
    t.integer "tmp_completed", limit: 8,          default: 0, null: false
    t.text    "value",         limit: 2147483647,             null: false
  end

  add_index "mdl_feedback_valuetmp", ["course_id"], name: "mdl_feedvalu_cou2_ix", using: :btree
  add_index "mdl_feedback_valuetmp", ["item"], name: "mdl_feedvalu_ite2_ix", using: :btree

  create_table "mdl_files", force: true do |t|
    t.string  "contenthash",     limit: 40,         default: "", null: false
    t.string  "pathnamehash",    limit: 40,         default: "", null: false
    t.integer "contextid",       limit: 8,                       null: false
    t.string  "component",       limit: 100,        default: "", null: false
    t.string  "filearea",        limit: 50,         default: "", null: false
    t.integer "itemid",          limit: 8,                       null: false
    t.string  "filepath",                           default: "", null: false
    t.string  "filename",                           default: "", null: false
    t.integer "userid",          limit: 8
    t.integer "filesize",        limit: 8,                       null: false
    t.string  "mimetype",        limit: 100
    t.integer "status",          limit: 8,          default: 0,  null: false
    t.text    "source",          limit: 2147483647
    t.string  "author"
    t.string  "license"
    t.integer "timecreated",     limit: 8,                       null: false
    t.integer "timemodified",    limit: 8,                       null: false
    t.integer "sortorder",       limit: 8,          default: 0,  null: false
    t.integer "referencefileid", limit: 8
  end

  add_index "mdl_files", ["component", "filearea", "contextid", "itemid"], name: "mdl_file_comfilconite_ix", using: :btree
  add_index "mdl_files", ["contenthash"], name: "mdl_file_con_ix", using: :btree
  add_index "mdl_files", ["contextid"], name: "mdl_file_con2_ix", using: :btree
  add_index "mdl_files", ["pathnamehash"], name: "mdl_file_pat_uix", unique: true, using: :btree
  add_index "mdl_files", ["referencefileid"], name: "mdl_file_ref_ix", using: :btree
  add_index "mdl_files", ["userid"], name: "mdl_file_use_ix", using: :btree

  create_table "mdl_files_reference", force: true do |t|
    t.integer "repositoryid",  limit: 8,                       null: false
    t.integer "lastsync",      limit: 8
    t.text    "reference",     limit: 2147483647
    t.string  "referencehash", limit: 40,         default: "", null: false
  end

  add_index "mdl_files_reference", ["repositoryid", "referencehash"], name: "mdl_filerefe_repref_uix", unique: true, using: :btree
  add_index "mdl_files_reference", ["repositoryid"], name: "mdl_filerefe_rep_ix", using: :btree

  create_table "mdl_filter_active", force: true do |t|
    t.string  "filter",    limit: 32, default: "", null: false
    t.integer "contextid", limit: 8,               null: false
    t.integer "active",    limit: 2,               null: false
    t.integer "sortorder", limit: 8,  default: 0,  null: false
  end

  add_index "mdl_filter_active", ["contextid", "filter"], name: "mdl_filtacti_confil_uix", unique: true, using: :btree
  add_index "mdl_filter_active", ["contextid"], name: "mdl_filtacti_con_ix", using: :btree

  create_table "mdl_filter_config", force: true do |t|
    t.string  "filter",    limit: 32,         default: "", null: false
    t.integer "contextid", limit: 8,                       null: false
    t.string  "name",                         default: "", null: false
    t.text    "value",     limit: 2147483647
  end

  add_index "mdl_filter_config", ["contextid", "filter", "name"], name: "mdl_filtconf_confilnam_uix", unique: true, using: :btree
  add_index "mdl_filter_config", ["contextid"], name: "mdl_filtconf_con_ix", using: :btree

  create_table "mdl_folder", force: true do |t|
    t.integer "course",       limit: 8,          default: 0,    null: false
    t.string  "name",                            default: "",   null: false
    t.text    "intro",        limit: 2147483647
    t.integer "introformat",  limit: 2,          default: 0,    null: false
    t.integer "revision",     limit: 8,          default: 0,    null: false
    t.boolean "showexpanded",                    default: true, null: false
    t.integer "timemodified", limit: 8,          default: 0,    null: false
    t.integer "display",      limit: 2,          default: 0,    null: false
  end

  add_index "mdl_folder", ["course"], name: "mdl_fold_cou_ix", using: :btree

  create_table "mdl_forum", force: true do |t|
    t.integer "course",                limit: 8,          default: 0,         null: false
    t.string  "type",                  limit: 20,         default: "general", null: false
    t.string  "name",                                     default: "",        null: false
    t.text    "intro",                 limit: 2147483647,                     null: false
    t.integer "introformat",           limit: 2,          default: 0,         null: false
    t.integer "assessed",              limit: 8,          default: 0,         null: false
    t.integer "assesstimestart",       limit: 8,          default: 0,         null: false
    t.integer "assesstimefinish",      limit: 8,          default: 0,         null: false
    t.integer "scale",                 limit: 8,          default: 0,         null: false
    t.integer "maxbytes",              limit: 8,          default: 0,         null: false
    t.integer "maxattachments",        limit: 8,          default: 1,         null: false
    t.boolean "forcesubscribe",                           default: false,     null: false
    t.integer "trackingtype",          limit: 1,          default: 1,         null: false
    t.integer "rsstype",               limit: 1,          default: 0,         null: false
    t.integer "rssarticles",           limit: 1,          default: 0,         null: false
    t.integer "timemodified",          limit: 8,          default: 0,         null: false
    t.integer "warnafter",             limit: 8,          default: 0,         null: false
    t.integer "blockafter",            limit: 8,          default: 0,         null: false
    t.integer "blockperiod",           limit: 8,          default: 0,         null: false
    t.integer "completiondiscussions",                    default: 0,         null: false
    t.integer "completionreplies",                        default: 0,         null: false
    t.integer "completionposts",                          default: 0,         null: false
    t.boolean "displaywordcount",                         default: false,     null: false
  end

  add_index "mdl_forum", ["course"], name: "mdl_foru_cou_ix", using: :btree

  create_table "mdl_forum_digests", force: true do |t|
    t.integer "userid",     limit: 8,                 null: false
    t.integer "forum",      limit: 8,                 null: false
    t.boolean "maildigest",           default: false, null: false
  end

  add_index "mdl_forum_digests", ["forum", "userid", "maildigest"], name: "mdl_forudige_forusemai_uix", unique: true, using: :btree
  add_index "mdl_forum_digests", ["forum"], name: "mdl_forudige_for_ix", using: :btree
  add_index "mdl_forum_digests", ["userid"], name: "mdl_forudige_use_ix", using: :btree

  create_table "mdl_forum_discussions", force: true do |t|
    t.integer "course",       limit: 8, default: 0,    null: false
    t.integer "forum",        limit: 8, default: 0,    null: false
    t.string  "name",                   default: "",   null: false
    t.integer "firstpost",    limit: 8, default: 0,    null: false
    t.integer "userid",       limit: 8, default: 0,    null: false
    t.integer "groupid",      limit: 8, default: -1,   null: false
    t.boolean "assessed",               default: true, null: false
    t.integer "timemodified", limit: 8, default: 0,    null: false
    t.integer "usermodified", limit: 8, default: 0,    null: false
    t.integer "timestart",    limit: 8, default: 0,    null: false
    t.integer "timeend",      limit: 8, default: 0,    null: false
  end

  add_index "mdl_forum_discussions", ["forum"], name: "mdl_forudisc_for_ix", using: :btree
  add_index "mdl_forum_discussions", ["userid"], name: "mdl_forudisc_use_ix", using: :btree

  create_table "mdl_forum_posts", force: true do |t|
    t.integer "discussion",    limit: 8,          default: 0,  null: false
    t.integer "parent",        limit: 8,          default: 0,  null: false
    t.integer "userid",        limit: 8,          default: 0,  null: false
    t.integer "created",       limit: 8,          default: 0,  null: false
    t.integer "modified",      limit: 8,          default: 0,  null: false
    t.integer "mailed",        limit: 1,          default: 0,  null: false
    t.string  "subject",                          default: "", null: false
    t.text    "message",       limit: 2147483647,              null: false
    t.integer "messageformat", limit: 1,          default: 0,  null: false
    t.integer "messagetrust",  limit: 1,          default: 0,  null: false
    t.string  "attachment",    limit: 100,        default: "", null: false
    t.integer "totalscore",    limit: 2,          default: 0,  null: false
    t.integer "mailnow",       limit: 8,          default: 0,  null: false
  end

  add_index "mdl_forum_posts", ["created"], name: "mdl_forupost_cre_ix", using: :btree
  add_index "mdl_forum_posts", ["discussion"], name: "mdl_forupost_dis_ix", using: :btree
  add_index "mdl_forum_posts", ["mailed"], name: "mdl_forupost_mai_ix", using: :btree
  add_index "mdl_forum_posts", ["parent"], name: "mdl_forupost_par_ix", using: :btree
  add_index "mdl_forum_posts", ["userid"], name: "mdl_forupost_use_ix", using: :btree

  create_table "mdl_forum_queue", force: true do |t|
    t.integer "userid",       limit: 8, default: 0, null: false
    t.integer "discussionid", limit: 8, default: 0, null: false
    t.integer "postid",       limit: 8, default: 0, null: false
    t.integer "timemodified", limit: 8, default: 0, null: false
  end

  add_index "mdl_forum_queue", ["discussionid"], name: "mdl_foruqueu_dis_ix", using: :btree
  add_index "mdl_forum_queue", ["postid"], name: "mdl_foruqueu_pos_ix", using: :btree
  add_index "mdl_forum_queue", ["userid"], name: "mdl_foruqueu_use_ix", using: :btree

  create_table "mdl_forum_read", force: true do |t|
    t.integer "userid",       limit: 8, default: 0, null: false
    t.integer "forumid",      limit: 8, default: 0, null: false
    t.integer "discussionid", limit: 8, default: 0, null: false
    t.integer "postid",       limit: 8, default: 0, null: false
    t.integer "firstread",    limit: 8, default: 0, null: false
    t.integer "lastread",     limit: 8, default: 0, null: false
  end

  add_index "mdl_forum_read", ["userid", "discussionid"], name: "mdl_foruread_usedis_ix", using: :btree
  add_index "mdl_forum_read", ["userid", "forumid"], name: "mdl_foruread_usefor_ix", using: :btree
  add_index "mdl_forum_read", ["userid", "postid"], name: "mdl_foruread_usepos_ix", using: :btree

  create_table "mdl_forum_subscriptions", force: true do |t|
    t.integer "userid", limit: 8, default: 0, null: false
    t.integer "forum",  limit: 8, default: 0, null: false
  end

  add_index "mdl_forum_subscriptions", ["forum"], name: "mdl_forusubs_for_ix", using: :btree
  add_index "mdl_forum_subscriptions", ["userid"], name: "mdl_forusubs_use_ix", using: :btree

  create_table "mdl_forum_track_prefs", force: true do |t|
    t.integer "userid",  limit: 8, default: 0, null: false
    t.integer "forumid", limit: 8, default: 0, null: false
  end

  add_index "mdl_forum_track_prefs", ["userid", "forumid"], name: "mdl_forutracpref_usefor_ix", using: :btree

  create_table "mdl_glossary", force: true do |t|
    t.integer "course",                 limit: 8,          default: 0,            null: false
    t.string  "name",                                      default: "",           null: false
    t.text    "intro",                  limit: 2147483647,                        null: false
    t.integer "introformat",            limit: 2,          default: 0,            null: false
    t.integer "allowduplicatedentries", limit: 1,          default: 0,            null: false
    t.string  "displayformat",          limit: 50,         default: "dictionary", null: false
    t.integer "mainglossary",           limit: 1,          default: 0,            null: false
    t.integer "showspecial",            limit: 1,          default: 1,            null: false
    t.integer "showalphabet",           limit: 1,          default: 1,            null: false
    t.integer "showall",                limit: 1,          default: 1,            null: false
    t.integer "allowcomments",          limit: 1,          default: 0,            null: false
    t.integer "allowprintview",         limit: 1,          default: 1,            null: false
    t.integer "usedynalink",            limit: 1,          default: 1,            null: false
    t.integer "defaultapproval",        limit: 1,          default: 1,            null: false
    t.string  "approvaldisplayformat",  limit: 50,         default: "default",    null: false
    t.integer "globalglossary",         limit: 1,          default: 0,            null: false
    t.integer "entbypage",              limit: 2,          default: 10,           null: false
    t.integer "editalways",             limit: 1,          default: 0,            null: false
    t.integer "rsstype",                limit: 1,          default: 0,            null: false
    t.integer "rssarticles",            limit: 1,          default: 0,            null: false
    t.integer "assessed",               limit: 8,          default: 0,            null: false
    t.integer "assesstimestart",        limit: 8,          default: 0,            null: false
    t.integer "assesstimefinish",       limit: 8,          default: 0,            null: false
    t.integer "scale",                  limit: 8,          default: 0,            null: false
    t.integer "timecreated",            limit: 8,          default: 0,            null: false
    t.integer "timemodified",           limit: 8,          default: 0,            null: false
    t.integer "completionentries",                         default: 0,            null: false
  end

  add_index "mdl_glossary", ["course"], name: "mdl_glos_cou_ix", using: :btree

  create_table "mdl_glossary_alias", force: true do |t|
    t.integer "entryid", limit: 8, default: 0,  null: false
    t.string  "alias",             default: "", null: false
  end

  add_index "mdl_glossary_alias", ["entryid"], name: "mdl_glosalia_ent_ix", using: :btree

  create_table "mdl_glossary_categories", force: true do |t|
    t.integer "glossaryid",  limit: 8, default: 0,  null: false
    t.string  "name",                  default: "", null: false
    t.integer "usedynalink", limit: 1, default: 1,  null: false
  end

  add_index "mdl_glossary_categories", ["glossaryid"], name: "mdl_gloscate_glo_ix", using: :btree

  create_table "mdl_glossary_entries", force: true do |t|
    t.integer "glossaryid",       limit: 8,          default: 0,  null: false
    t.integer "userid",           limit: 8,          default: 0,  null: false
    t.string  "concept",                             default: "", null: false
    t.text    "definition",       limit: 2147483647,              null: false
    t.integer "definitionformat", limit: 1,          default: 0,  null: false
    t.integer "definitiontrust",  limit: 1,          default: 0,  null: false
    t.string  "attachment",       limit: 100,        default: "", null: false
    t.integer "timecreated",      limit: 8,          default: 0,  null: false
    t.integer "timemodified",     limit: 8,          default: 0,  null: false
    t.integer "teacherentry",     limit: 1,          default: 0,  null: false
    t.integer "sourceglossaryid", limit: 8,          default: 0,  null: false
    t.integer "usedynalink",      limit: 1,          default: 1,  null: false
    t.integer "casesensitive",    limit: 1,          default: 0,  null: false
    t.integer "fullmatch",        limit: 1,          default: 1,  null: false
    t.integer "approved",         limit: 1,          default: 1,  null: false
  end

  add_index "mdl_glossary_entries", ["concept"], name: "mdl_glosentr_con_ix", using: :btree
  add_index "mdl_glossary_entries", ["glossaryid"], name: "mdl_glosentr_glo_ix", using: :btree
  add_index "mdl_glossary_entries", ["userid"], name: "mdl_glosentr_use_ix", using: :btree

  create_table "mdl_glossary_entries_categories", force: true do |t|
    t.integer "categoryid", limit: 8, default: 0, null: false
    t.integer "entryid",    limit: 8, default: 0, null: false
  end

  add_index "mdl_glossary_entries_categories", ["categoryid"], name: "mdl_glosentrcate_cat_ix", using: :btree
  add_index "mdl_glossary_entries_categories", ["entryid"], name: "mdl_glosentrcate_ent_ix", using: :btree

  create_table "mdl_glossary_formats", force: true do |t|
    t.string  "name",            limit: 50, default: "", null: false
    t.string  "popupformatname", limit: 50, default: "", null: false
    t.integer "visible",         limit: 1,  default: 1,  null: false
    t.integer "showgroup",       limit: 1,  default: 1,  null: false
    t.string  "defaultmode",     limit: 50, default: "", null: false
    t.string  "defaulthook",     limit: 50, default: "", null: false
    t.string  "sortkey",         limit: 50, default: "", null: false
    t.string  "sortorder",       limit: 50, default: "", null: false
  end

  create_table "mdl_grade_categories", force: true do |t|
    t.integer "courseid",            limit: 8,                 null: false
    t.integer "parent",              limit: 8
    t.integer "depth",               limit: 8, default: 0,     null: false
    t.string  "path"
    t.string  "fullname",                      default: "",    null: false
    t.integer "aggregation",         limit: 8, default: 0,     null: false
    t.integer "keephigh",            limit: 8, default: 0,     null: false
    t.integer "droplow",             limit: 8, default: 0,     null: false
    t.boolean "aggregateonlygraded",           default: false, null: false
    t.boolean "aggregateoutcomes",             default: false, null: false
    t.boolean "aggregatesubcats",              default: false, null: false
    t.integer "timecreated",         limit: 8,                 null: false
    t.integer "timemodified",        limit: 8,                 null: false
    t.boolean "hidden",                        default: false, null: false
  end

  add_index "mdl_grade_categories", ["courseid"], name: "mdl_gradcate_cou_ix", using: :btree
  add_index "mdl_grade_categories", ["parent"], name: "mdl_gradcate_par_ix", using: :btree

  create_table "mdl_grade_categories_history", force: true do |t|
    t.integer "action",              limit: 8, default: 0,     null: false
    t.integer "oldid",               limit: 8,                 null: false
    t.string  "source"
    t.integer "timemodified",        limit: 8
    t.boolean "hidden",                        default: false, null: false
    t.integer "loggeduser",          limit: 8
    t.integer "courseid",            limit: 8,                 null: false
    t.integer "parent",              limit: 8
    t.integer "depth",               limit: 8, default: 0,     null: false
    t.string  "path"
    t.string  "fullname",                      default: "",    null: false
    t.integer "aggregation",         limit: 8, default: 0,     null: false
    t.integer "keephigh",            limit: 8, default: 0,     null: false
    t.integer "droplow",             limit: 8, default: 0,     null: false
    t.boolean "aggregateonlygraded",           default: false, null: false
    t.boolean "aggregateoutcomes",             default: false, null: false
    t.boolean "aggregatesubcats",              default: false, null: false
  end

  add_index "mdl_grade_categories_history", ["action"], name: "mdl_gradcatehist_act_ix", using: :btree
  add_index "mdl_grade_categories_history", ["courseid"], name: "mdl_gradcatehist_cou_ix", using: :btree
  add_index "mdl_grade_categories_history", ["loggeduser"], name: "mdl_gradcatehist_log_ix", using: :btree
  add_index "mdl_grade_categories_history", ["oldid"], name: "mdl_gradcatehist_old_ix", using: :btree
  add_index "mdl_grade_categories_history", ["parent"], name: "mdl_gradcatehist_par_ix", using: :btree

  create_table "mdl_grade_grades", force: true do |t|
    t.integer "itemid",            limit: 8,                                                   null: false
    t.integer "userid",            limit: 8,                                                   null: false
    t.decimal "rawgrade",                             precision: 10, scale: 5
    t.decimal "rawgrademax",                          precision: 10, scale: 5, default: 100.0, null: false
    t.decimal "rawgrademin",                          precision: 10, scale: 5, default: 0.0,   null: false
    t.integer "rawscaleid",        limit: 8
    t.integer "usermodified",      limit: 8
    t.decimal "finalgrade",                           precision: 10, scale: 5
    t.integer "hidden",            limit: 8,                                   default: 0,     null: false
    t.integer "locked",            limit: 8,                                   default: 0,     null: false
    t.integer "locktime",          limit: 8,                                   default: 0,     null: false
    t.integer "exported",          limit: 8,                                   default: 0,     null: false
    t.integer "overridden",        limit: 8,                                   default: 0,     null: false
    t.integer "excluded",          limit: 8,                                   default: 0,     null: false
    t.text    "feedback",          limit: 2147483647
    t.integer "feedbackformat",    limit: 8,                                   default: 0,     null: false
    t.text    "information",       limit: 2147483647
    t.integer "informationformat", limit: 8,                                   default: 0,     null: false
    t.integer "timecreated",       limit: 8
    t.integer "timemodified",      limit: 8
  end

  add_index "mdl_grade_grades", ["itemid"], name: "mdl_gradgrad_ite_ix", using: :btree
  add_index "mdl_grade_grades", ["locked", "locktime"], name: "mdl_gradgrad_locloc_ix", using: :btree
  add_index "mdl_grade_grades", ["rawscaleid"], name: "mdl_gradgrad_raw_ix", using: :btree
  add_index "mdl_grade_grades", ["userid", "itemid"], name: "mdl_gradgrad_useite_uix", unique: true, using: :btree
  add_index "mdl_grade_grades", ["userid"], name: "mdl_gradgrad_use_ix", using: :btree
  add_index "mdl_grade_grades", ["usermodified"], name: "mdl_gradgrad_use2_ix", using: :btree

  create_table "mdl_grade_grades_history", force: true do |t|
    t.integer "action",            limit: 8,                                   default: 0,     null: false
    t.integer "oldid",             limit: 8,                                                   null: false
    t.string  "source"
    t.integer "timemodified",      limit: 8
    t.integer "loggeduser",        limit: 8
    t.integer "itemid",            limit: 8,                                                   null: false
    t.integer "userid",            limit: 8,                                                   null: false
    t.decimal "rawgrade",                             precision: 10, scale: 5
    t.decimal "rawgrademax",                          precision: 10, scale: 5, default: 100.0, null: false
    t.decimal "rawgrademin",                          precision: 10, scale: 5, default: 0.0,   null: false
    t.integer "rawscaleid",        limit: 8
    t.integer "usermodified",      limit: 8
    t.decimal "finalgrade",                           precision: 10, scale: 5
    t.integer "hidden",            limit: 8,                                   default: 0,     null: false
    t.integer "locked",            limit: 8,                                   default: 0,     null: false
    t.integer "locktime",          limit: 8,                                   default: 0,     null: false
    t.integer "exported",          limit: 8,                                   default: 0,     null: false
    t.integer "overridden",        limit: 8,                                   default: 0,     null: false
    t.integer "excluded",          limit: 8,                                   default: 0,     null: false
    t.text    "feedback",          limit: 2147483647
    t.integer "feedbackformat",    limit: 8,                                   default: 0,     null: false
    t.text    "information",       limit: 2147483647
    t.integer "informationformat", limit: 8,                                   default: 0,     null: false
  end

  add_index "mdl_grade_grades_history", ["action"], name: "mdl_gradgradhist_act_ix", using: :btree
  add_index "mdl_grade_grades_history", ["itemid"], name: "mdl_gradgradhist_ite_ix", using: :btree
  add_index "mdl_grade_grades_history", ["loggeduser"], name: "mdl_gradgradhist_log_ix", using: :btree
  add_index "mdl_grade_grades_history", ["oldid"], name: "mdl_gradgradhist_old_ix", using: :btree
  add_index "mdl_grade_grades_history", ["rawscaleid"], name: "mdl_gradgradhist_raw_ix", using: :btree
  add_index "mdl_grade_grades_history", ["timemodified"], name: "mdl_gradgradhist_tim_ix", using: :btree
  add_index "mdl_grade_grades_history", ["userid"], name: "mdl_gradgradhist_use_ix", using: :btree
  add_index "mdl_grade_grades_history", ["usermodified"], name: "mdl_gradgradhist_use2_ix", using: :btree

  create_table "mdl_grade_import_newitem", force: true do |t|
    t.string  "itemname",             default: "", null: false
    t.integer "importcode", limit: 8,              null: false
    t.integer "importer",   limit: 8,              null: false
  end

  add_index "mdl_grade_import_newitem", ["importer"], name: "mdl_gradimponewi_imp_ix", using: :btree

  create_table "mdl_grade_import_values", force: true do |t|
    t.integer "itemid",       limit: 8
    t.integer "newgradeitem", limit: 8
    t.integer "userid",       limit: 8,                                   null: false
    t.decimal "finalgrade",                      precision: 10, scale: 5
    t.text    "feedback",     limit: 2147483647
    t.integer "importcode",   limit: 8,                                   null: false
    t.integer "importer",     limit: 8
  end

  add_index "mdl_grade_import_values", ["importer"], name: "mdl_gradimpovalu_imp_ix", using: :btree
  add_index "mdl_grade_import_values", ["itemid"], name: "mdl_gradimpovalu_ite_ix", using: :btree
  add_index "mdl_grade_import_values", ["newgradeitem"], name: "mdl_gradimpovalu_new_ix", using: :btree

  create_table "mdl_grade_items", force: true do |t|
    t.integer "courseid",        limit: 8
    t.integer "categoryid",      limit: 8
    t.string  "itemname"
    t.string  "itemtype",        limit: 30,                                  default: "",    null: false
    t.string  "itemmodule",      limit: 30
    t.integer "iteminstance",    limit: 8
    t.integer "itemnumber",      limit: 8
    t.text    "iteminfo",        limit: 2147483647
    t.string  "idnumber"
    t.text    "calculation",     limit: 2147483647
    t.integer "gradetype",       limit: 2,                                   default: 1,     null: false
    t.decimal "grademax",                           precision: 10, scale: 5, default: 100.0, null: false
    t.decimal "grademin",                           precision: 10, scale: 5, default: 0.0,   null: false
    t.integer "scaleid",         limit: 8
    t.integer "outcomeid",       limit: 8
    t.decimal "gradepass",                          precision: 10, scale: 5, default: 0.0,   null: false
    t.decimal "multfactor",                         precision: 10, scale: 5, default: 1.0,   null: false
    t.decimal "plusfactor",                         precision: 10, scale: 5, default: 0.0,   null: false
    t.decimal "aggregationcoef",                    precision: 10, scale: 5, default: 0.0,   null: false
    t.integer "sortorder",       limit: 8,                                   default: 0,     null: false
    t.integer "display",         limit: 8,                                   default: 0,     null: false
    t.boolean "decimals"
    t.integer "hidden",          limit: 8,                                   default: 0,     null: false
    t.integer "locked",          limit: 8,                                   default: 0,     null: false
    t.integer "locktime",        limit: 8,                                   default: 0,     null: false
    t.integer "needsupdate",     limit: 8,                                   default: 0,     null: false
    t.integer "timecreated",     limit: 8
    t.integer "timemodified",    limit: 8
  end

  add_index "mdl_grade_items", ["categoryid"], name: "mdl_graditem_cat_ix", using: :btree
  add_index "mdl_grade_items", ["courseid"], name: "mdl_graditem_cou_ix", using: :btree
  add_index "mdl_grade_items", ["gradetype"], name: "mdl_graditem_gra_ix", using: :btree
  add_index "mdl_grade_items", ["idnumber", "courseid"], name: "mdl_graditem_idncou_ix", using: :btree
  add_index "mdl_grade_items", ["itemtype", "needsupdate"], name: "mdl_graditem_itenee_ix", using: :btree
  add_index "mdl_grade_items", ["locked", "locktime"], name: "mdl_graditem_locloc_ix", using: :btree
  add_index "mdl_grade_items", ["outcomeid"], name: "mdl_graditem_out_ix", using: :btree
  add_index "mdl_grade_items", ["scaleid"], name: "mdl_graditem_sca_ix", using: :btree

  create_table "mdl_grade_items_history", force: true do |t|
    t.integer "action",          limit: 8,                                   default: 0,     null: false
    t.integer "oldid",           limit: 8,                                                   null: false
    t.string  "source"
    t.integer "timemodified",    limit: 8
    t.integer "loggeduser",      limit: 8
    t.integer "courseid",        limit: 8
    t.integer "categoryid",      limit: 8
    t.string  "itemname"
    t.string  "itemtype",        limit: 30,                                  default: "",    null: false
    t.string  "itemmodule",      limit: 30
    t.integer "iteminstance",    limit: 8
    t.integer "itemnumber",      limit: 8
    t.text    "iteminfo",        limit: 2147483647
    t.string  "idnumber"
    t.text    "calculation",     limit: 2147483647
    t.integer "gradetype",       limit: 2,                                   default: 1,     null: false
    t.decimal "grademax",                           precision: 10, scale: 5, default: 100.0, null: false
    t.decimal "grademin",                           precision: 10, scale: 5, default: 0.0,   null: false
    t.integer "scaleid",         limit: 8
    t.integer "outcomeid",       limit: 8
    t.decimal "gradepass",                          precision: 10, scale: 5, default: 0.0,   null: false
    t.decimal "multfactor",                         precision: 10, scale: 5, default: 1.0,   null: false
    t.decimal "plusfactor",                         precision: 10, scale: 5, default: 0.0,   null: false
    t.decimal "aggregationcoef",                    precision: 10, scale: 5, default: 0.0,   null: false
    t.integer "sortorder",       limit: 8,                                   default: 0,     null: false
    t.integer "display",         limit: 8,                                   default: 0,     null: false
    t.boolean "decimals"
    t.integer "hidden",          limit: 8,                                   default: 0,     null: false
    t.integer "locked",          limit: 8,                                   default: 0,     null: false
    t.integer "locktime",        limit: 8,                                   default: 0,     null: false
    t.integer "needsupdate",     limit: 8,                                   default: 0,     null: false
  end

  add_index "mdl_grade_items_history", ["action"], name: "mdl_graditemhist_act_ix", using: :btree
  add_index "mdl_grade_items_history", ["categoryid"], name: "mdl_graditemhist_cat_ix", using: :btree
  add_index "mdl_grade_items_history", ["courseid"], name: "mdl_graditemhist_cou_ix", using: :btree
  add_index "mdl_grade_items_history", ["loggeduser"], name: "mdl_graditemhist_log_ix", using: :btree
  add_index "mdl_grade_items_history", ["oldid"], name: "mdl_graditemhist_old_ix", using: :btree
  add_index "mdl_grade_items_history", ["outcomeid"], name: "mdl_graditemhist_out_ix", using: :btree
  add_index "mdl_grade_items_history", ["scaleid"], name: "mdl_graditemhist_sca_ix", using: :btree

  create_table "mdl_grade_letters", force: true do |t|
    t.integer "contextid",     limit: 8,                                       null: false
    t.decimal "lowerboundary",           precision: 10, scale: 5,              null: false
    t.string  "letter",                                           default: "", null: false
  end

  add_index "mdl_grade_letters", ["contextid", "lowerboundary", "letter"], name: "mdl_gradlett_conlowlet_uix", unique: true, using: :btree

  create_table "mdl_grade_outcomes", force: true do |t|
    t.integer "courseid",          limit: 8
    t.string  "shortname",                            default: "", null: false
    t.text    "fullname",          limit: 2147483647,              null: false
    t.integer "scaleid",           limit: 8
    t.text    "description",       limit: 2147483647
    t.integer "descriptionformat", limit: 1,          default: 0,  null: false
    t.integer "timecreated",       limit: 8
    t.integer "timemodified",      limit: 8
    t.integer "usermodified",      limit: 8
  end

  add_index "mdl_grade_outcomes", ["courseid", "shortname"], name: "mdl_gradoutc_cousho_uix", unique: true, using: :btree
  add_index "mdl_grade_outcomes", ["courseid"], name: "mdl_gradoutc_cou_ix", using: :btree
  add_index "mdl_grade_outcomes", ["scaleid"], name: "mdl_gradoutc_sca_ix", using: :btree
  add_index "mdl_grade_outcomes", ["usermodified"], name: "mdl_gradoutc_use_ix", using: :btree

  create_table "mdl_grade_outcomes_courses", force: true do |t|
    t.integer "courseid",  limit: 8, null: false
    t.integer "outcomeid", limit: 8, null: false
  end

  add_index "mdl_grade_outcomes_courses", ["courseid", "outcomeid"], name: "mdl_gradoutccour_couout_uix", unique: true, using: :btree
  add_index "mdl_grade_outcomes_courses", ["courseid"], name: "mdl_gradoutccour_cou_ix", using: :btree
  add_index "mdl_grade_outcomes_courses", ["outcomeid"], name: "mdl_gradoutccour_out_ix", using: :btree

  create_table "mdl_grade_outcomes_history", force: true do |t|
    t.integer "action",            limit: 8,          default: 0,  null: false
    t.integer "oldid",             limit: 8,                       null: false
    t.string  "source"
    t.integer "timemodified",      limit: 8
    t.integer "loggeduser",        limit: 8
    t.integer "courseid",          limit: 8
    t.string  "shortname",                            default: "", null: false
    t.text    "fullname",          limit: 2147483647,              null: false
    t.integer "scaleid",           limit: 8
    t.text    "description",       limit: 2147483647
    t.integer "descriptionformat", limit: 1,          default: 0,  null: false
  end

  add_index "mdl_grade_outcomes_history", ["action"], name: "mdl_gradoutchist_act_ix", using: :btree
  add_index "mdl_grade_outcomes_history", ["courseid"], name: "mdl_gradoutchist_cou_ix", using: :btree
  add_index "mdl_grade_outcomes_history", ["loggeduser"], name: "mdl_gradoutchist_log_ix", using: :btree
  add_index "mdl_grade_outcomes_history", ["oldid"], name: "mdl_gradoutchist_old_ix", using: :btree
  add_index "mdl_grade_outcomes_history", ["scaleid"], name: "mdl_gradoutchist_sca_ix", using: :btree

  create_table "mdl_grade_settings", force: true do |t|
    t.integer "courseid", limit: 8,                       null: false
    t.string  "name",                        default: "", null: false
    t.text    "value",    limit: 2147483647
  end

  add_index "mdl_grade_settings", ["courseid", "name"], name: "mdl_gradsett_counam_uix", unique: true, using: :btree
  add_index "mdl_grade_settings", ["courseid"], name: "mdl_gradsett_cou_ix", using: :btree

  create_table "mdl_grading_areas", force: true do |t|
    t.integer "contextid",    limit: 8,                null: false
    t.string  "component",    limit: 100, default: "", null: false
    t.string  "areaname",     limit: 100, default: "", null: false
    t.string  "activemethod", limit: 100
  end

  add_index "mdl_grading_areas", ["contextid", "component", "areaname"], name: "mdl_gradarea_concomare_uix", unique: true, using: :btree
  add_index "mdl_grading_areas", ["contextid"], name: "mdl_gradarea_con_ix", using: :btree

  create_table "mdl_grading_definitions", force: true do |t|
    t.integer "areaid",            limit: 8,                       null: false
    t.string  "method",            limit: 100,        default: "", null: false
    t.string  "name",                                 default: "", null: false
    t.text    "description",       limit: 2147483647
    t.integer "descriptionformat", limit: 1
    t.integer "status",            limit: 8,          default: 0,  null: false
    t.integer "copiedfromid",      limit: 8
    t.integer "timecreated",       limit: 8,                       null: false
    t.integer "usercreated",       limit: 8,                       null: false
    t.integer "timemodified",      limit: 8,                       null: false
    t.integer "usermodified",      limit: 8,                       null: false
    t.integer "timecopied",        limit: 8,          default: 0
    t.text    "options",           limit: 2147483647
  end

  add_index "mdl_grading_definitions", ["areaid", "method"], name: "mdl_graddefi_aremet_uix", unique: true, using: :btree
  add_index "mdl_grading_definitions", ["areaid"], name: "mdl_graddefi_are_ix", using: :btree
  add_index "mdl_grading_definitions", ["usercreated"], name: "mdl_graddefi_use2_ix", using: :btree
  add_index "mdl_grading_definitions", ["usermodified"], name: "mdl_graddefi_use_ix", using: :btree

  create_table "mdl_grading_instances", force: true do |t|
    t.integer "definitionid",   limit: 8,                                               null: false
    t.integer "raterid",        limit: 8,                                               null: false
    t.integer "itemid",         limit: 8
    t.decimal "rawgrade",                          precision: 10, scale: 5
    t.integer "status",         limit: 8,                                   default: 0, null: false
    t.text    "feedback",       limit: 2147483647
    t.integer "feedbackformat", limit: 1
    t.integer "timemodified",   limit: 8,                                               null: false
  end

  add_index "mdl_grading_instances", ["definitionid"], name: "mdl_gradinst_def_ix", using: :btree
  add_index "mdl_grading_instances", ["raterid"], name: "mdl_gradinst_rat_ix", using: :btree

  create_table "mdl_gradingform_guide_comments", force: true do |t|
    t.integer "definitionid",      limit: 8,          null: false
    t.integer "sortorder",         limit: 8,          null: false
    t.text    "description",       limit: 2147483647
    t.integer "descriptionformat", limit: 1
  end

  add_index "mdl_gradingform_guide_comments", ["definitionid"], name: "mdl_gradguidcomm_def_ix", using: :btree

  create_table "mdl_gradingform_guide_criteria", force: true do |t|
    t.integer "definitionid",             limit: 8,                                                null: false
    t.integer "sortorder",                limit: 8,                                                null: false
    t.string  "shortname",                                                            default: "", null: false
    t.text    "description",              limit: 2147483647
    t.integer "descriptionformat",        limit: 1
    t.text    "descriptionmarkers",       limit: 2147483647
    t.integer "descriptionmarkersformat", limit: 1
    t.decimal "maxscore",                                    precision: 10, scale: 5,              null: false
  end

  add_index "mdl_gradingform_guide_criteria", ["definitionid"], name: "mdl_gradguidcrit_def_ix", using: :btree

  create_table "mdl_gradingform_guide_fillings", force: true do |t|
    t.integer "instanceid",   limit: 8,                                   null: false
    t.integer "criterionid",  limit: 8,                                   null: false
    t.text    "remark",       limit: 2147483647
    t.integer "remarkformat", limit: 1
    t.decimal "score",                           precision: 10, scale: 5, null: false
  end

  add_index "mdl_gradingform_guide_fillings", ["criterionid"], name: "mdl_gradguidfill_cri_ix", using: :btree
  add_index "mdl_gradingform_guide_fillings", ["instanceid", "criterionid"], name: "mdl_gradguidfill_inscri_uix", unique: true, using: :btree
  add_index "mdl_gradingform_guide_fillings", ["instanceid"], name: "mdl_gradguidfill_ins_ix", using: :btree

  create_table "mdl_gradingform_rubric_criteria", force: true do |t|
    t.integer "definitionid",      limit: 8,          null: false
    t.integer "sortorder",         limit: 8,          null: false
    t.text    "description",       limit: 2147483647
    t.integer "descriptionformat", limit: 1
  end

  add_index "mdl_gradingform_rubric_criteria", ["definitionid"], name: "mdl_gradrubrcrit_def_ix", using: :btree

  create_table "mdl_gradingform_rubric_fillings", force: true do |t|
    t.integer "instanceid",   limit: 8,          null: false
    t.integer "criterionid",  limit: 8,          null: false
    t.integer "levelid",      limit: 8
    t.text    "remark",       limit: 2147483647
    t.integer "remarkformat", limit: 1
  end

  add_index "mdl_gradingform_rubric_fillings", ["criterionid"], name: "mdl_gradrubrfill_cri_ix", using: :btree
  add_index "mdl_gradingform_rubric_fillings", ["instanceid", "criterionid"], name: "mdl_gradrubrfill_inscri_uix", unique: true, using: :btree
  add_index "mdl_gradingform_rubric_fillings", ["instanceid"], name: "mdl_gradrubrfill_ins_ix", using: :btree
  add_index "mdl_gradingform_rubric_fillings", ["levelid"], name: "mdl_gradrubrfill_lev_ix", using: :btree

  create_table "mdl_gradingform_rubric_levels", force: true do |t|
    t.integer "criterionid",      limit: 8,                                   null: false
    t.decimal "score",                               precision: 10, scale: 5, null: false
    t.text    "definition",       limit: 2147483647
    t.integer "definitionformat", limit: 8
  end

  add_index "mdl_gradingform_rubric_levels", ["criterionid"], name: "mdl_gradrubrleve_cri_ix", using: :btree

  create_table "mdl_groupings", force: true do |t|
    t.integer "courseid",          limit: 8,          default: 0,  null: false
    t.string  "name",                                 default: "", null: false
    t.string  "idnumber",          limit: 100,        default: "", null: false
    t.text    "description",       limit: 2147483647
    t.integer "descriptionformat", limit: 1,          default: 0,  null: false
    t.text    "configdata",        limit: 2147483647
    t.integer "timecreated",       limit: 8,          default: 0,  null: false
    t.integer "timemodified",      limit: 8,          default: 0,  null: false
  end

  add_index "mdl_groupings", ["courseid"], name: "mdl_grou_cou2_ix", using: :btree
  add_index "mdl_groupings", ["idnumber"], name: "mdl_grou_idn2_ix", using: :btree

  create_table "mdl_groupings_groups", force: true do |t|
    t.integer "groupingid", limit: 8, default: 0, null: false
    t.integer "groupid",    limit: 8, default: 0, null: false
    t.integer "timeadded",  limit: 8, default: 0, null: false
  end

  add_index "mdl_groupings_groups", ["groupid"], name: "mdl_grougrou_gro2_ix", using: :btree
  add_index "mdl_groupings_groups", ["groupingid"], name: "mdl_grougrou_gro_ix", using: :btree

  create_table "mdl_groups", force: true do |t|
    t.integer "courseid",          limit: 8,                          null: false
    t.string  "idnumber",          limit: 100,        default: "",    null: false
    t.string  "name",              limit: 254,        default: "",    null: false
    t.text    "description",       limit: 2147483647
    t.integer "descriptionformat", limit: 1,          default: 0,     null: false
    t.string  "enrolmentkey",      limit: 50
    t.integer "picture",           limit: 8,          default: 0,     null: false
    t.boolean "hidepicture",                          default: false, null: false
    t.integer "timecreated",       limit: 8,          default: 0,     null: false
    t.integer "timemodified",      limit: 8,          default: 0,     null: false
  end

  add_index "mdl_groups", ["courseid"], name: "mdl_grou_cou_ix", using: :btree
  add_index "mdl_groups", ["idnumber"], name: "mdl_grou_idn_ix", using: :btree

  create_table "mdl_groups_members", force: true do |t|
    t.integer "groupid",   limit: 8,   default: 0,  null: false
    t.integer "userid",    limit: 8,   default: 0,  null: false
    t.integer "timeadded", limit: 8,   default: 0,  null: false
    t.string  "component", limit: 100, default: "", null: false
    t.integer "itemid",    limit: 8,   default: 0,  null: false
  end

  add_index "mdl_groups_members", ["groupid"], name: "mdl_groumemb_gro_ix", using: :btree
  add_index "mdl_groups_members", ["userid"], name: "mdl_groumemb_use_ix", using: :btree

  create_table "mdl_imscp", force: true do |t|
    t.integer "course",       limit: 8,          default: 0,  null: false
    t.string  "name",                            default: "", null: false
    t.text    "intro",        limit: 2147483647
    t.integer "introformat",  limit: 2,          default: 0,  null: false
    t.integer "revision",     limit: 8,          default: 0,  null: false
    t.integer "keepold",      limit: 8,          default: -1, null: false
    t.text    "structure",    limit: 2147483647
    t.integer "timemodified", limit: 8,          default: 0,  null: false
  end

  add_index "mdl_imscp", ["course"], name: "mdl_imsc_cou_ix", using: :btree

  create_table "mdl_label", force: true do |t|
    t.integer "course",       limit: 8,          default: 0,  null: false
    t.string  "name",                            default: "", null: false
    t.text    "intro",        limit: 2147483647,              null: false
    t.integer "introformat",  limit: 2,          default: 0
    t.integer "timemodified", limit: 8,          default: 0,  null: false
  end

  add_index "mdl_label", ["course"], name: "mdl_labe_cou_ix", using: :btree

  create_table "mdl_lesson", force: true do |t|
    t.integer "course",          limit: 8,          default: 0,         null: false
    t.string  "name",                               default: "",        null: false
    t.integer "practice",        limit: 2,          default: 0,         null: false
    t.integer "modattempts",     limit: 2,          default: 0,         null: false
    t.integer "usepassword",     limit: 2,          default: 0,         null: false
    t.string  "password",        limit: 32,         default: "",        null: false
    t.integer "dependency",      limit: 8,          default: 0,         null: false
    t.text    "conditions",      limit: 2147483647,                     null: false
    t.integer "grade",           limit: 2,          default: 0,         null: false
    t.integer "custom",          limit: 2,          default: 0,         null: false
    t.integer "ongoing",         limit: 2,          default: 0,         null: false
    t.integer "usemaxgrade",     limit: 2,          default: 0,         null: false
    t.integer "maxanswers",      limit: 2,          default: 4,         null: false
    t.integer "maxattempts",     limit: 2,          default: 5,         null: false
    t.integer "review",          limit: 2,          default: 0,         null: false
    t.integer "nextpagedefault", limit: 2,          default: 0,         null: false
    t.integer "feedback",        limit: 2,          default: 1,         null: false
    t.integer "minquestions",    limit: 2,          default: 0,         null: false
    t.integer "maxpages",        limit: 2,          default: 0,         null: false
    t.integer "timed",           limit: 2,          default: 0,         null: false
    t.integer "maxtime",         limit: 8,          default: 0,         null: false
    t.integer "retake",          limit: 2,          default: 1,         null: false
    t.integer "activitylink",    limit: 8,          default: 0,         null: false
    t.string  "mediafile",                          default: "",        null: false
    t.integer "mediaheight",     limit: 8,          default: 100,       null: false
    t.integer "mediawidth",      limit: 8,          default: 650,       null: false
    t.integer "mediaclose",      limit: 2,          default: 0,         null: false
    t.integer "slideshow",       limit: 2,          default: 0,         null: false
    t.integer "width",           limit: 8,          default: 640,       null: false
    t.integer "height",          limit: 8,          default: 480,       null: false
    t.string  "bgcolor",         limit: 7,          default: "#FFFFFF", null: false
    t.integer "displayleft",     limit: 2,          default: 0,         null: false
    t.integer "displayleftif",   limit: 2,          default: 0,         null: false
    t.integer "progressbar",     limit: 2,          default: 0,         null: false
    t.integer "highscores",      limit: 2,          default: 0,         null: false
    t.integer "maxhighscores",   limit: 8,          default: 0,         null: false
    t.integer "available",       limit: 8,          default: 0,         null: false
    t.integer "deadline",        limit: 8,          default: 0,         null: false
    t.integer "timemodified",    limit: 8,          default: 0,         null: false
  end

  add_index "mdl_lesson", ["course"], name: "mdl_less_cou_ix", using: :btree

  create_table "mdl_lesson_answers", force: true do |t|
    t.integer "lessonid",       limit: 8,          default: 0, null: false
    t.integer "pageid",         limit: 8,          default: 0, null: false
    t.integer "jumpto",         limit: 8,          default: 0, null: false
    t.integer "grade",          limit: 2,          default: 0, null: false
    t.integer "score",          limit: 8,          default: 0, null: false
    t.integer "flags",          limit: 2,          default: 0, null: false
    t.integer "timecreated",    limit: 8,          default: 0, null: false
    t.integer "timemodified",   limit: 8,          default: 0, null: false
    t.text    "answer",         limit: 2147483647
    t.integer "answerformat",   limit: 1,          default: 0, null: false
    t.text    "response",       limit: 2147483647
    t.integer "responseformat", limit: 1,          default: 0, null: false
  end

  add_index "mdl_lesson_answers", ["lessonid"], name: "mdl_lessansw_les_ix", using: :btree
  add_index "mdl_lesson_answers", ["pageid"], name: "mdl_lessansw_pag_ix", using: :btree

  create_table "mdl_lesson_attempts", force: true do |t|
    t.integer "lessonid",   limit: 8,          default: 0, null: false
    t.integer "pageid",     limit: 8,          default: 0, null: false
    t.integer "userid",     limit: 8,          default: 0, null: false
    t.integer "answerid",   limit: 8,          default: 0, null: false
    t.integer "retry",      limit: 2,          default: 0, null: false
    t.integer "correct",    limit: 8,          default: 0, null: false
    t.text    "useranswer", limit: 2147483647
    t.integer "timeseen",   limit: 8,          default: 0, null: false
  end

  add_index "mdl_lesson_attempts", ["answerid"], name: "mdl_lessatte_ans_ix", using: :btree
  add_index "mdl_lesson_attempts", ["lessonid"], name: "mdl_lessatte_les_ix", using: :btree
  add_index "mdl_lesson_attempts", ["pageid"], name: "mdl_lessatte_pag_ix", using: :btree
  add_index "mdl_lesson_attempts", ["userid"], name: "mdl_lessatte_use_ix", using: :btree

  create_table "mdl_lesson_branch", force: true do |t|
    t.integer "lessonid", limit: 8, default: 0, null: false
    t.integer "userid",   limit: 8, default: 0, null: false
    t.integer "pageid",   limit: 8, default: 0, null: false
    t.integer "retry",    limit: 8, default: 0, null: false
    t.integer "flag",     limit: 2, default: 0, null: false
    t.integer "timeseen", limit: 8, default: 0, null: false
  end

  add_index "mdl_lesson_branch", ["lessonid"], name: "mdl_lessbran_les_ix", using: :btree
  add_index "mdl_lesson_branch", ["pageid"], name: "mdl_lessbran_pag_ix", using: :btree
  add_index "mdl_lesson_branch", ["userid"], name: "mdl_lessbran_use_ix", using: :btree

  create_table "mdl_lesson_grades", force: true do |t|
    t.integer "lessonid",  limit: 8, default: 0,   null: false
    t.integer "userid",    limit: 8, default: 0,   null: false
    t.float   "grade",               default: 0.0, null: false
    t.integer "late",      limit: 2, default: 0,   null: false
    t.integer "completed", limit: 8, default: 0,   null: false
  end

  add_index "mdl_lesson_grades", ["lessonid"], name: "mdl_lessgrad_les_ix", using: :btree
  add_index "mdl_lesson_grades", ["userid"], name: "mdl_lessgrad_use_ix", using: :btree

  create_table "mdl_lesson_high_scores", force: true do |t|
    t.integer "lessonid", limit: 8, default: 0,  null: false
    t.integer "userid",   limit: 8, default: 0,  null: false
    t.integer "gradeid",  limit: 8, default: 0,  null: false
    t.string  "nickname", limit: 5, default: "", null: false
  end

  add_index "mdl_lesson_high_scores", ["lessonid"], name: "mdl_lesshighscor_les_ix", using: :btree
  add_index "mdl_lesson_high_scores", ["userid"], name: "mdl_lesshighscor_use_ix", using: :btree

  create_table "mdl_lesson_pages", force: true do |t|
    t.integer "lessonid",       limit: 8,          default: 0,  null: false
    t.integer "prevpageid",     limit: 8,          default: 0,  null: false
    t.integer "nextpageid",     limit: 8,          default: 0,  null: false
    t.integer "qtype",          limit: 2,          default: 0,  null: false
    t.integer "qoption",        limit: 2,          default: 0,  null: false
    t.integer "layout",         limit: 2,          default: 1,  null: false
    t.integer "display",        limit: 2,          default: 1,  null: false
    t.integer "timecreated",    limit: 8,          default: 0,  null: false
    t.integer "timemodified",   limit: 8,          default: 0,  null: false
    t.string  "title",                             default: "", null: false
    t.text    "contents",       limit: 2147483647,              null: false
    t.integer "contentsformat", limit: 1,          default: 0,  null: false
  end

  add_index "mdl_lesson_pages", ["lessonid"], name: "mdl_lesspage_les_ix", using: :btree

  create_table "mdl_lesson_timer", force: true do |t|
    t.integer "lessonid",   limit: 8, default: 0, null: false
    t.integer "userid",     limit: 8, default: 0, null: false
    t.integer "starttime",  limit: 8, default: 0, null: false
    t.integer "lessontime", limit: 8, default: 0, null: false
  end

  add_index "mdl_lesson_timer", ["lessonid"], name: "mdl_lesstime_les_ix", using: :btree
  add_index "mdl_lesson_timer", ["userid"], name: "mdl_lesstime_use_ix", using: :btree

  create_table "mdl_license", force: true do |t|
    t.string  "shortname"
    t.text    "fullname",  limit: 2147483647
    t.string  "source"
    t.boolean "enabled",                      default: true, null: false
    t.integer "version",   limit: 8,          default: 0,    null: false
  end

  create_table "mdl_log", force: true do |t|
    t.integer "time",   limit: 8,   default: 0,  null: false
    t.integer "userid", limit: 8,   default: 0,  null: false
    t.string  "ip",     limit: 45,  default: "", null: false
    t.integer "course", limit: 8,   default: 0,  null: false
    t.string  "module", limit: 20,  default: "", null: false
    t.integer "cmid",   limit: 8,   default: 0,  null: false
    t.string  "action", limit: 40,  default: "", null: false
    t.string  "url",    limit: 100, default: "", null: false
    t.string  "info",               default: "", null: false
  end

  add_index "mdl_log", ["action"], name: "mdl_log_act_ix", using: :btree
  add_index "mdl_log", ["cmid"], name: "mdl_log_cmi_ix", using: :btree
  add_index "mdl_log", ["course", "module", "action"], name: "mdl_log_coumodact_ix", using: :btree
  add_index "mdl_log", ["time"], name: "mdl_log_tim_ix", using: :btree
  add_index "mdl_log", ["userid", "course"], name: "mdl_log_usecou_ix", using: :btree

  create_table "mdl_log_display", force: true do |t|
    t.string "module",    limit: 20,  default: "", null: false
    t.string "action",    limit: 40,  default: "", null: false
    t.string "mtable",    limit: 30,  default: "", null: false
    t.string "field",     limit: 200, default: "", null: false
    t.string "component", limit: 100, default: "", null: false
  end

  add_index "mdl_log_display", ["module", "action"], name: "mdl_logdisp_modact_uix", unique: true, using: :btree

  create_table "mdl_log_queries", force: true do |t|
    t.integer "qtype",      limit: 3,                                               null: false
    t.text    "sqltext",    limit: 2147483647,                                      null: false
    t.text    "sqlparams",  limit: 2147483647
    t.integer "error",      limit: 3,                                   default: 0, null: false
    t.text    "info",       limit: 2147483647
    t.text    "backtrace",  limit: 2147483647
    t.decimal "exectime",                      precision: 10, scale: 5,             null: false
    t.integer "timelogged", limit: 8,                                               null: false
  end

  create_table "mdl_lti", force: true do |t|
    t.integer "course",                        limit: 8,                                   default: 0,     null: false
    t.string  "name",                                                                      default: "",    null: false
    t.text    "intro",                         limit: 2147483647
    t.integer "introformat",                   limit: 2,                                   default: 0
    t.integer "timecreated",                   limit: 8,                                   default: 0,     null: false
    t.integer "timemodified",                  limit: 8,                                   default: 0,     null: false
    t.integer "typeid",                        limit: 8
    t.text    "toolurl",                       limit: 2147483647,                                          null: false
    t.text    "securetoolurl",                 limit: 2147483647
    t.boolean "instructorchoicesendname"
    t.boolean "instructorchoicesendemailaddr"
    t.boolean "instructorchoiceallowroster"
    t.boolean "instructorchoiceallowsetting"
    t.string  "instructorcustomparameters"
    t.boolean "instructorchoiceacceptgrades"
    t.decimal "grade",                                            precision: 10, scale: 5, default: 100.0, null: false
    t.integer "launchcontainer",               limit: 1,                                   default: 1,     null: false
    t.string  "resourcekey"
    t.string  "password"
    t.boolean "debuglaunch",                                                               default: false, null: false
    t.boolean "showtitlelaunch",                                                           default: false, null: false
    t.boolean "showdescriptionlaunch",                                                     default: false, null: false
    t.string  "servicesalt",                   limit: 40
    t.text    "icon",                          limit: 2147483647
    t.text    "secureicon",                    limit: 2147483647
  end

  add_index "mdl_lti", ["course"], name: "mdl_lti_cou_ix", using: :btree

  create_table "mdl_lti_submission", force: true do |t|
    t.integer "ltiid",         limit: 8,                          null: false
    t.integer "userid",        limit: 8,                          null: false
    t.integer "datesubmitted", limit: 8,                          null: false
    t.integer "dateupdated",   limit: 8,                          null: false
    t.decimal "gradepercent",            precision: 10, scale: 5, null: false
    t.decimal "originalgrade",           precision: 10, scale: 5, null: false
    t.integer "launchid",      limit: 8,                          null: false
    t.integer "state",         limit: 1,                          null: false
  end

  add_index "mdl_lti_submission", ["ltiid"], name: "mdl_ltisubm_lti_ix", using: :btree

  create_table "mdl_lti_types", force: true do |t|
    t.string  "name",                             default: "basiclti Activity", null: false
    t.text    "baseurl",       limit: 2147483647,                               null: false
    t.string  "tooldomain",                       default: "",                  null: false
    t.integer "state",         limit: 1,          default: 2,                   null: false
    t.integer "course",        limit: 8,                                        null: false
    t.boolean "coursevisible",                    default: false,               null: false
    t.integer "createdby",     limit: 8,                                        null: false
    t.integer "timecreated",   limit: 8,                                        null: false
    t.integer "timemodified",  limit: 8,                                        null: false
  end

  add_index "mdl_lti_types", ["course"], name: "mdl_ltitype_cou_ix", using: :btree
  add_index "mdl_lti_types", ["tooldomain"], name: "mdl_ltitype_too_ix", using: :btree

  create_table "mdl_lti_types_config", force: true do |t|
    t.integer "typeid", limit: 8,                null: false
    t.string  "name",   limit: 100, default: "", null: false
    t.string  "value",              default: "", null: false
  end

  add_index "mdl_lti_types_config", ["typeid"], name: "mdl_ltitypeconf_typ_ix", using: :btree

  create_table "mdl_message", force: true do |t|
    t.integer "useridfrom",        limit: 8,          default: 0,     null: false
    t.integer "useridto",          limit: 8,          default: 0,     null: false
    t.text    "fullmessage",       limit: 2147483647
    t.integer "fullmessageformat", limit: 2,          default: 0
    t.integer "timecreated",       limit: 8,          default: 0,     null: false
    t.text    "subject",           limit: 2147483647
    t.text    "fullmessagehtml",   limit: 2147483647
    t.text    "smallmessage",      limit: 2147483647
    t.boolean "notification",                         default: false
    t.text    "contexturl",        limit: 2147483647
    t.text    "contexturlname",    limit: 2147483647
  end

  add_index "mdl_message", ["useridfrom"], name: "mdl_mess_use_ix", using: :btree
  add_index "mdl_message", ["useridto"], name: "mdl_mess_use2_ix", using: :btree

  create_table "mdl_message_contacts", force: true do |t|
    t.integer "userid",    limit: 8, default: 0,     null: false
    t.integer "contactid", limit: 8, default: 0,     null: false
    t.boolean "blocked",             default: false, null: false
  end

  add_index "mdl_message_contacts", ["userid", "contactid"], name: "mdl_messcont_usecon_uix", unique: true, using: :btree

  create_table "mdl_message_processors", force: true do |t|
    t.string  "name",    limit: 166, default: "",   null: false
    t.boolean "enabled",             default: true, null: false
  end

  create_table "mdl_message_providers", force: true do |t|
    t.string "name",       limit: 100, default: "", null: false
    t.string "component",  limit: 200, default: "", null: false
    t.string "capability"
  end

  add_index "mdl_message_providers", ["component", "name"], name: "mdl_messprov_comnam_uix", unique: true, using: :btree

  create_table "mdl_message_read", force: true do |t|
    t.integer "useridfrom",        limit: 8,          default: 0,     null: false
    t.integer "useridto",          limit: 8,          default: 0,     null: false
    t.text    "fullmessage",       limit: 2147483647
    t.integer "fullmessageformat", limit: 2,          default: 0
    t.integer "timecreated",       limit: 8,          default: 0,     null: false
    t.integer "timeread",          limit: 8,          default: 0,     null: false
    t.text    "subject",           limit: 2147483647
    t.text    "fullmessagehtml",   limit: 2147483647
    t.text    "smallmessage",      limit: 2147483647
    t.boolean "notification",                         default: false
    t.text    "contexturl",        limit: 2147483647
    t.text    "contexturlname",    limit: 2147483647
  end

  add_index "mdl_message_read", ["useridfrom"], name: "mdl_messread_use_ix", using: :btree
  add_index "mdl_message_read", ["useridto"], name: "mdl_messread_use2_ix", using: :btree

  create_table "mdl_message_working", force: true do |t|
    t.integer "unreadmessageid", limit: 8, null: false
    t.integer "processorid",     limit: 8, null: false
  end

  add_index "mdl_message_working", ["unreadmessageid"], name: "mdl_messwork_unr_ix", using: :btree

  create_table "mdl_mnet_application", force: true do |t|
    t.string "name",              limit: 50, default: "", null: false
    t.string "display_name",      limit: 50, default: "", null: false
    t.string "xmlrpc_server_url",            default: "", null: false
    t.string "sso_land_url",                 default: "", null: false
    t.string "sso_jump_url",                 default: "", null: false
  end

  create_table "mdl_mnet_host", force: true do |t|
    t.boolean "deleted",                               default: false, null: false
    t.string  "wwwroot",                               default: "",    null: false
    t.string  "ip_address",         limit: 45,         default: "",    null: false
    t.string  "name",               limit: 80,         default: "",    null: false
    t.text    "public_key",         limit: 2147483647,                 null: false
    t.integer "public_key_expires", limit: 8,          default: 0,     null: false
    t.integer "transport",          limit: 1,          default: 0,     null: false
    t.integer "portno",             limit: 3,          default: 0,     null: false
    t.integer "last_connect_time",  limit: 8,          default: 0,     null: false
    t.integer "last_log_id",        limit: 8,          default: 0,     null: false
    t.boolean "force_theme",                           default: false, null: false
    t.string  "theme",              limit: 100
    t.integer "applicationid",      limit: 8,          default: 1,     null: false
  end

  add_index "mdl_mnet_host", ["applicationid"], name: "mdl_mnethost_app_ix", using: :btree

  create_table "mdl_mnet_host2service", force: true do |t|
    t.integer "hostid",    limit: 8, default: 0,     null: false
    t.integer "serviceid", limit: 8, default: 0,     null: false
    t.boolean "publish",             default: false, null: false
    t.boolean "subscribe",           default: false, null: false
  end

  add_index "mdl_mnet_host2service", ["hostid", "serviceid"], name: "mdl_mnethost_hosser_uix", unique: true, using: :btree

  create_table "mdl_mnet_log", force: true do |t|
    t.integer "hostid",     limit: 8,   default: 0,  null: false
    t.integer "remoteid",   limit: 8,   default: 0,  null: false
    t.integer "time",       limit: 8,   default: 0,  null: false
    t.integer "userid",     limit: 8,   default: 0,  null: false
    t.string  "ip",         limit: 45,  default: "", null: false
    t.integer "course",     limit: 8,   default: 0,  null: false
    t.string  "coursename", limit: 40,  default: "", null: false
    t.string  "module",     limit: 20,  default: "", null: false
    t.integer "cmid",       limit: 8,   default: 0,  null: false
    t.string  "action",     limit: 40,  default: "", null: false
    t.string  "url",        limit: 100, default: "", null: false
    t.string  "info",                   default: "", null: false
  end

  add_index "mdl_mnet_log", ["hostid", "userid", "course"], name: "mdl_mnetlog_hosusecou_ix", using: :btree

  create_table "mdl_mnet_remote_rpc", force: true do |t|
    t.string  "functionname", limit: 40, default: "", null: false
    t.string  "xmlrpcpath",   limit: 80, default: "", null: false
    t.string  "plugintype",   limit: 20, default: "", null: false
    t.string  "pluginname",   limit: 20, default: "", null: false
    t.boolean "enabled",                              null: false
  end

  create_table "mdl_mnet_remote_service2rpc", force: true do |t|
    t.integer "serviceid", limit: 8, default: 0, null: false
    t.integer "rpcid",     limit: 8, default: 0, null: false
  end

  add_index "mdl_mnet_remote_service2rpc", ["rpcid", "serviceid"], name: "mdl_mnetremoserv_rpcser_uix", unique: true, using: :btree

  create_table "mdl_mnet_rpc", force: true do |t|
    t.string  "functionname", limit: 40,         default: "",    null: false
    t.string  "xmlrpcpath",   limit: 80,         default: "",    null: false
    t.string  "plugintype",   limit: 20,         default: "",    null: false
    t.string  "pluginname",   limit: 20,         default: "",    null: false
    t.boolean "enabled",                         default: false, null: false
    t.text    "help",         limit: 2147483647,                 null: false
    t.text    "profile",      limit: 2147483647,                 null: false
    t.string  "filename",     limit: 100,        default: "",    null: false
    t.string  "classname",    limit: 150
    t.boolean "static"
  end

  add_index "mdl_mnet_rpc", ["enabled", "xmlrpcpath"], name: "mdl_mnetrpc_enaxml_ix", using: :btree

  create_table "mdl_mnet_service", force: true do |t|
    t.string  "name",        limit: 40, default: "",    null: false
    t.string  "description", limit: 40, default: "",    null: false
    t.string  "apiversion",  limit: 10, default: "",    null: false
    t.boolean "offer",                  default: false, null: false
  end

  create_table "mdl_mnet_service2rpc", force: true do |t|
    t.integer "serviceid", limit: 8, default: 0, null: false
    t.integer "rpcid",     limit: 8, default: 0, null: false
  end

  add_index "mdl_mnet_service2rpc", ["rpcid", "serviceid"], name: "mdl_mnetserv_rpcser_uix", unique: true, using: :btree

  create_table "mdl_mnet_session", force: true do |t|
    t.integer "userid",          limit: 8,   default: 0,  null: false
    t.string  "username",        limit: 100, default: "", null: false
    t.string  "token",           limit: 40,  default: "", null: false
    t.integer "mnethostid",      limit: 8,   default: 0,  null: false
    t.string  "useragent",       limit: 40,  default: "", null: false
    t.integer "confirm_timeout", limit: 8,   default: 0,  null: false
    t.string  "session_id",      limit: 40,  default: "", null: false
    t.integer "expires",         limit: 8,   default: 0,  null: false
  end

  add_index "mdl_mnet_session", ["token"], name: "mdl_mnetsess_tok_uix", unique: true, using: :btree

  create_table "mdl_mnet_sso_access_control", force: true do |t|
    t.string  "username",     limit: 100, default: "",      null: false
    t.integer "mnet_host_id", limit: 8,   default: 0,       null: false
    t.string  "accessctrl",   limit: 20,  default: "allow", null: false
  end

  add_index "mdl_mnet_sso_access_control", ["mnet_host_id", "username"], name: "mdl_mnetssoaccecont_mneuse_uix", unique: true, using: :btree

  create_table "mdl_mnetservice_enrol_courses", force: true do |t|
    t.integer "hostid",        limit: 8,                       null: false
    t.integer "remoteid",      limit: 8,                       null: false
    t.integer "categoryid",    limit: 8,                       null: false
    t.string  "categoryname",                     default: "", null: false
    t.integer "sortorder",     limit: 8,          default: 0,  null: false
    t.string  "fullname",      limit: 254,        default: "", null: false
    t.string  "shortname",     limit: 100,        default: "", null: false
    t.string  "idnumber",      limit: 100,        default: "", null: false
    t.text    "summary",       limit: 2147483647,              null: false
    t.integer "summaryformat", limit: 2,          default: 0
    t.integer "startdate",     limit: 8,                       null: false
    t.integer "roleid",        limit: 8,                       null: false
    t.string  "rolename",                         default: "", null: false
  end

  add_index "mdl_mnetservice_enrol_courses", ["hostid", "remoteid"], name: "mdl_mnetenrocour_hosrem_uix", unique: true, using: :btree

  create_table "mdl_mnetservice_enrol_enrolments", force: true do |t|
    t.integer "hostid",         limit: 8,               null: false
    t.integer "userid",         limit: 8,               null: false
    t.integer "remotecourseid", limit: 8,               null: false
    t.string  "rolename",                  default: "", null: false
    t.integer "enroltime",      limit: 8,  default: 0,  null: false
    t.string  "enroltype",      limit: 20, default: "", null: false
  end

  add_index "mdl_mnetservice_enrol_enrolments", ["hostid"], name: "mdl_mnetenroenro_hos_ix", using: :btree
  add_index "mdl_mnetservice_enrol_enrolments", ["userid"], name: "mdl_mnetenroenro_use_ix", using: :btree

  create_table "mdl_modules", force: true do |t|
    t.string  "name",     limit: 20, default: "",   null: false
    t.integer "cron",     limit: 8,  default: 0,    null: false
    t.integer "lastcron", limit: 8,  default: 0,    null: false
    t.string  "search",              default: "",   null: false
    t.boolean "visible",             default: true, null: false
  end

  add_index "mdl_modules", ["name"], name: "mdl_modu_nam_ix", using: :btree

  create_table "mdl_my_pages", force: true do |t|
    t.integer "userid",    limit: 8,   default: 0
    t.string  "name",      limit: 200, default: "",   null: false
    t.boolean "private",               default: true, null: false
    t.integer "sortorder", limit: 3,   default: 0,    null: false
  end

  add_index "mdl_my_pages", ["userid", "private"], name: "mdl_mypage_usepri_ix", using: :btree

  create_table "mdl_page", force: true do |t|
    t.integer "course",          limit: 8,          default: 0,  null: false
    t.string  "name",                               default: "", null: false
    t.text    "intro",           limit: 2147483647
    t.integer "introformat",     limit: 2,          default: 0,  null: false
    t.text    "content",         limit: 2147483647
    t.integer "contentformat",   limit: 2,          default: 0,  null: false
    t.integer "legacyfiles",     limit: 2,          default: 0,  null: false
    t.integer "legacyfileslast", limit: 8
    t.integer "display",         limit: 2,          default: 0,  null: false
    t.text    "displayoptions",  limit: 2147483647
    t.integer "revision",        limit: 8,          default: 0,  null: false
    t.integer "timemodified",    limit: 8,          default: 0,  null: false
  end

  add_index "mdl_page", ["course"], name: "mdl_page_cou_ix", using: :btree

  create_table "mdl_portfolio_heap", force: true do |t|
    t.integer "userid",                                     default: 0,     null: false
    t.string  "title",                                      default: "",    null: false
    t.text    "comments",                limit: 2147483647,                 null: false
    t.text    "teacher_comments",        limit: 2147483647,                 null: false
    t.string  "keywords",                                   default: "",    null: false
    t.boolean "locked",                                     default: false, null: false
    t.boolean "userdefault",                                default: false, null: false
    t.text    "bgimage",                 limit: 2147483647,                 null: false
    t.string  "bgcolor",                                    default: "",    null: false
    t.string  "bgtextcolor",                                default: "",    null: false
    t.string  "bgurlcolor",                                 default: "",    null: false
    t.text    "fgimage",                 limit: 2147483647,                 null: false
    t.string  "fgcolor",                                    default: "",    null: false
    t.string  "fgtextcolor",                                default: "",    null: false
    t.string  "fgurlcolor",                                 default: "",    null: false
    t.string  "bgcolor_itemdefault",                        default: "",    null: false
    t.string  "bgtextcolor_itemdefault",                    default: "",    null: false
    t.string  "bgurlcolor_itemdefault",                     default: "",    null: false
    t.string  "fgcolor_itemdefault",                        default: "",    null: false
    t.string  "fgtextcolor_itemdefault",                    default: "",    null: false
    t.text    "custom_data",             limit: 2147483647,                 null: false
    t.text    "custom_bgimage",          limit: 2147483647,                 null: false
    t.string  "custom_bgcolor",                             default: "",    null: false
    t.string  "custom_bgtextcolor",                         default: "",    null: false
    t.string  "custom_bgurlcolor",                          default: "",    null: false
    t.text    "custom_fgimage",          limit: 2147483647,                 null: false
    t.string  "custom_fgcolor",                             default: "",    null: false
    t.string  "custom_fgtextcolor",                         default: "",    null: false
    t.string  "custom_fgurlcolor",                          default: "",    null: false
    t.integer "timecreated",                                default: 0,     null: false
    t.integer "timemodified",                               default: 0,     null: false
  end

  add_index "mdl_portfolio_heap", ["keywords"], name: "mdl_portfolio_heap_keywords_ix", using: :btree
  add_index "mdl_portfolio_heap", ["timecreated"], name: "mdl_portfolio_heap_timecreated_ix", using: :btree
  add_index "mdl_portfolio_heap", ["timemodified"], name: "mdl_portfolio_heap_timemodified_ix", using: :btree
  add_index "mdl_portfolio_heap", ["title"], name: "mdl_portfolio_heap_title_ix", using: :btree
  add_index "mdl_portfolio_heap", ["userid", "title"], name: "mdl_portfolio_heap_unique", unique: true, using: :btree
  add_index "mdl_portfolio_heap", ["userid", "title"], name: "mdl_portfolio_heap_usertitle_uix", unique: true, using: :btree
  add_index "mdl_portfolio_heap", ["userid"], name: "mdl_portfolio_heap_userid_ix", using: :btree

  create_table "mdl_portfolio_heap_item", force: true do |t|
    t.integer "heapid", default: 0, null: false
    t.integer "itemid", default: 0, null: false
  end

  add_index "mdl_portfolio_heap_item", ["heapid", "itemid"], name: "mdl_portfolio_heap_item_hi_uix", unique: true, using: :btree
  add_index "mdl_portfolio_heap_item", ["heapid", "itemid"], name: "mdl_portfolio_heap_item_unique", unique: true, using: :btree
  add_index "mdl_portfolio_heap_item", ["heapid"], name: "mdl_portfolio_heap_item_heap_ix", using: :btree
  add_index "mdl_portfolio_heap_item", ["itemid"], name: "mdl_portfolio_heap_item_item_ix", using: :btree

  create_table "mdl_portfolio_instance", force: true do |t|
    t.string  "plugin",  limit: 50, default: "",   null: false
    t.string  "name",               default: "",   null: false
    t.boolean "visible",            default: true, null: false
  end

  create_table "mdl_portfolio_instance_config", force: true do |t|
    t.integer "instance", limit: 8,                       null: false
    t.string  "name",                        default: "", null: false
    t.text    "value",    limit: 2147483647
  end

  add_index "mdl_portfolio_instance_config", ["instance"], name: "mdl_portinstconf_ins_ix", using: :btree
  add_index "mdl_portfolio_instance_config", ["name"], name: "mdl_portinstconf_nam_ix", using: :btree

  create_table "mdl_portfolio_instance_user", force: true do |t|
    t.integer "instance", limit: 8,                       null: false
    t.integer "userid",   limit: 8,                       null: false
    t.string  "name",                        default: "", null: false
    t.text    "value",    limit: 2147483647
  end

  add_index "mdl_portfolio_instance_user", ["instance"], name: "mdl_portinstuser_ins_ix", using: :btree
  add_index "mdl_portfolio_instance_user", ["userid"], name: "mdl_portinstuser_use_ix", using: :btree

  create_table "mdl_portfolio_item", force: true do |t|
    t.integer "userid",                                       default: 0,     null: false
    t.string  "item_type",                                    default: "",    null: false
    t.integer "orig_objectid",                                default: 0,     null: false
    t.string  "title",                                        default: "",    null: false
    t.text    "contents",                  limit: 2147483647,                 null: false
    t.boolean "nofiles",                                      default: false, null: false
    t.string  "tag_comments",                                 default: "",    null: false
    t.string  "tagc_comments",                                default: "",    null: false
    t.text    "comments",                  limit: 2147483647,                 null: false
    t.text    "teacher_comments",          limit: 2147483647,                 null: false
    t.string  "keywords",                                     default: "",    null: false
    t.integer "orig_courseid",                                default: 0,     null: false
    t.string  "orig_course_name",                             default: "",    null: false
    t.string  "orig_course_category_name",                    default: "",    null: false
    t.boolean "locked",                                       default: false, null: false
    t.text    "bgimage",                   limit: 2147483647,                 null: false
    t.string  "bgcolor",                                      default: "",    null: false
    t.string  "bgtextcolor",                                  default: "",    null: false
    t.string  "bgurlcolor",                                   default: "",    null: false
    t.text    "fgimage",                   limit: 2147483647,                 null: false
    t.string  "fgcolor",                                      default: "",    null: false
    t.string  "fgtextcolor",                                  default: "",    null: false
    t.string  "fgurlcolor",                                   default: "",    null: false
    t.text    "custom_data",               limit: 2147483647,                 null: false
    t.text    "custom_bgimage",            limit: 2147483647,                 null: false
    t.string  "custom_bgcolor",                               default: "",    null: false
    t.string  "custom_bgtextcolor",                           default: "",    null: false
    t.string  "custom_bgurlcolor",                            default: "",    null: false
    t.text    "custom_fgimage",            limit: 2147483647,                 null: false
    t.string  "custom_fgcolor",                               default: "",    null: false
    t.string  "custom_fgtextcolor",                           default: "",    null: false
    t.string  "custom_fgurlcolor",                            default: "",    null: false
    t.integer "version",                                      default: 0,     null: false
    t.integer "previous_versionid",                           default: 0,     null: false
    t.integer "next_versionid",                               default: 0,     null: false
    t.integer "timecreated",                                  default: 0,     null: false
    t.integer "timemodified",                                 default: 0,     null: false
  end

  add_index "mdl_portfolio_item", ["keywords"], name: "mdl_portfolio_item_keywords_ix", using: :btree
  add_index "mdl_portfolio_item", ["orig_objectid", "item_type", "userid"], name: "mdl_portfolio_item_origtypeuser_ix", using: :btree
  add_index "mdl_portfolio_item", ["timecreated"], name: "mdl_portfolio_item_timecreated_ix", using: :btree
  add_index "mdl_portfolio_item", ["timemodified"], name: "mdl_portfolio_item_timemodified_ix", using: :btree
  add_index "mdl_portfolio_item", ["title"], name: "mdl_portfolio_item_title_ix", using: :btree
  add_index "mdl_portfolio_item", ["userid"], name: "mdl_portfolio_item_userid_ix", using: :btree

  create_table "mdl_portfolio_item_tag", force: true do |t|
    t.integer "pfitemid", default: 0, null: false
    t.integer "tagid",    default: 1, null: false
  end

  add_index "mdl_portfolio_item_tag", ["pfitemid", "tagid"], name: "mdl_portfolio_item_tag_itemtag_uix", unique: true, using: :btree
  add_index "mdl_portfolio_item_tag", ["pfitemid", "tagid"], name: "mdl_portfolio_item_tag_unique", unique: true, using: :btree
  add_index "mdl_portfolio_item_tag", ["pfitemid"], name: "mdl_portfolio_item_tag_pfitemid_ix", using: :btree
  add_index "mdl_portfolio_item_tag", ["tagid"], name: "mdl_portfolio_item_tag_tagid_ix", using: :btree

  create_table "mdl_portfolio_log", force: true do |t|
    t.integer "userid",           limit: 8,                null: false
    t.integer "time",             limit: 8,                null: false
    t.integer "portfolio",        limit: 8,                null: false
    t.string  "caller_class",     limit: 150, default: "", null: false
    t.string  "caller_file",                  default: "", null: false
    t.string  "caller_component"
    t.string  "caller_sha1",                  default: "", null: false
    t.integer "tempdataid",       limit: 8,   default: 0,  null: false
    t.string  "returnurl",                    default: "", null: false
    t.string  "continueurl",                  default: "", null: false
  end

  add_index "mdl_portfolio_log", ["portfolio"], name: "mdl_portlog_por_ix", using: :btree
  add_index "mdl_portfolio_log", ["userid"], name: "mdl_portlog_use_ix", using: :btree

  create_table "mdl_portfolio_mahara_queue", force: true do |t|
    t.integer "transferid", limit: 8,               null: false
    t.string  "token",      limit: 50, default: "", null: false
  end

  add_index "mdl_portfolio_mahara_queue", ["token"], name: "mdl_portmahaqueu_tok_ix", using: :btree
  add_index "mdl_portfolio_mahara_queue", ["transferid"], name: "mdl_portmahaqueu_tra_ix", using: :btree

  create_table "mdl_portfolio_pfsys_version", force: true do |t|
    t.string "version", default: "", null: false
  end

  create_table "mdl_portfolio_tag", force: true do |t|
    t.integer "type",                     default: 0,  null: false
    t.string  "lctag",                    default: "", null: false
    t.string  "tag",                      default: "", null: false
    t.text    "url",   limit: 2147483647,              null: false
  end

  add_index "mdl_portfolio_tag", ["lctag"], name: "mdl_portfolio_tag_lctag_uix", unique: true, using: :btree
  add_index "mdl_portfolio_tag", ["lctag"], name: "mdl_portfolio_tag_unique", unique: true, using: :btree
  add_index "mdl_portfolio_tag", ["tag"], name: "mdl_portfolio_tag_tag_ix", using: :btree

  create_table "mdl_portfolio_tempdata", force: true do |t|
    t.text    "data",       limit: 2147483647
    t.integer "expirytime", limit: 8,                      null: false
    t.integer "userid",     limit: 8,                      null: false
    t.integer "instance",   limit: 8,          default: 0
  end

  add_index "mdl_portfolio_tempdata", ["instance"], name: "mdl_porttemp_ins_ix", using: :btree
  add_index "mdl_portfolio_tempdata", ["userid"], name: "mdl_porttemp_use_ix", using: :btree

  create_table "mdl_portfolio_test", force: true do |t|
    t.string  "testname", default: "", null: false
    t.integer "testdate", default: 0,  null: false
  end

  add_index "mdl_portfolio_test", ["testdate"], name: "mdl_portfolio_test_testdate_ix", using: :btree
  add_index "mdl_portfolio_test", ["testname", "testdate"], name: "mdl_portfolio_test_namedate_uix", unique: true, using: :btree
  add_index "mdl_portfolio_test", ["testname", "testdate"], name: "mdl_portfolio_test_unique", unique: true, using: :btree
  add_index "mdl_portfolio_test", ["testname"], name: "mdl_portfolio_test_testname_ix", using: :btree

  create_table "mdl_portfolio_test_score", force: true do |t|
    t.integer "userid",    default: 0,  null: false
    t.integer "sectionid", default: 0,  null: false
    t.integer "tagid",     default: 0,  null: false
    t.string  "score",     default: "", null: false
  end

  add_index "mdl_portfolio_test_score", ["sectionid", "tagid"], name: "mdl_portfolio_test_score_sectiontag_ix", using: :btree
  add_index "mdl_portfolio_test_score", ["sectionid"], name: "mdl_portfolio_test_score_sectionid_ix", using: :btree
  add_index "mdl_portfolio_test_score", ["tagid"], name: "mdl_portfolio_test_score_tagid_ix", using: :btree
  add_index "mdl_portfolio_test_score", ["userid", "sectionid"], name: "mdl_portfolio_test_score_unique", unique: true, using: :btree
  add_index "mdl_portfolio_test_score", ["userid", "sectionid"], name: "mdl_portfolio_test_score_usersection_uix", unique: true, using: :btree
  add_index "mdl_portfolio_test_score", ["userid", "tagid"], name: "mdl_portfolio_test_score_usertag_ix", using: :btree
  add_index "mdl_portfolio_test_score", ["userid"], name: "mdl_portfolio_test_score_userid_ix", using: :btree

  create_table "mdl_portfolio_test_section", force: true do |t|
    t.string  "sectionname", default: "", null: false
    t.integer "testid",      default: 0,  null: false
  end

  add_index "mdl_portfolio_test_section", ["sectionname", "testid"], name: "mdl_portfolio_test_section_nameid_uix", unique: true, using: :btree
  add_index "mdl_portfolio_test_section", ["sectionname", "testid"], name: "mdl_portfolio_test_section_unique", unique: true, using: :btree
  add_index "mdl_portfolio_test_section", ["sectionname"], name: "mdl_portfolio_test_section_sectionname_ix", using: :btree
  add_index "mdl_portfolio_test_section", ["testid"], name: "mdl_portfolio_test_section_testid_ix", using: :btree

  create_table "mdl_portfolio_test_section_tag", force: true do |t|
    t.integer "sectionid", default: 0, null: false
    t.integer "tagid",     default: 1, null: false
  end

  add_index "mdl_portfolio_test_section_tag", ["sectionid", "tagid"], name: "mdl_portfolio_test_section_tag_sectiontag_uix", unique: true, using: :btree
  add_index "mdl_portfolio_test_section_tag", ["sectionid", "tagid"], name: "mdl_portfolio_test_section_tag_unique", unique: true, using: :btree
  add_index "mdl_portfolio_test_section_tag", ["sectionid"], name: "mdl_portfolio_test_section_tag_sectionid_ix", using: :btree
  add_index "mdl_portfolio_test_section_tag", ["tagid"], name: "mdl_portfolio_test_section_tag_tagid_ix", using: :btree

  create_table "mdl_post", force: true do |t|
    t.string  "module",         limit: 20,         default: "",      null: false
    t.integer "userid",         limit: 8,          default: 0,       null: false
    t.integer "courseid",       limit: 8,          default: 0,       null: false
    t.integer "groupid",        limit: 8,          default: 0,       null: false
    t.integer "moduleid",       limit: 8,          default: 0,       null: false
    t.integer "coursemoduleid", limit: 8,          default: 0,       null: false
    t.string  "subject",        limit: 128,        default: "",      null: false
    t.text    "summary",        limit: 2147483647
    t.text    "content",        limit: 2147483647
    t.string  "uniquehash",                        default: "",      null: false
    t.integer "rating",         limit: 8,          default: 0,       null: false
    t.integer "format",         limit: 8,          default: 0,       null: false
    t.integer "summaryformat",  limit: 1,          default: 0,       null: false
    t.string  "attachment",     limit: 100
    t.string  "publishstate",   limit: 20,         default: "draft", null: false
    t.integer "lastmodified",   limit: 8,          default: 0,       null: false
    t.integer "created",        limit: 8,          default: 0,       null: false
    t.integer "usermodified",   limit: 8
  end

  add_index "mdl_post", ["id", "userid"], name: "mdl_post_iduse_uix", unique: true, using: :btree
  add_index "mdl_post", ["lastmodified"], name: "mdl_post_las_ix", using: :btree
  add_index "mdl_post", ["module"], name: "mdl_post_mod_ix", using: :btree
  add_index "mdl_post", ["subject"], name: "mdl_post_sub_ix", using: :btree
  add_index "mdl_post", ["usermodified"], name: "mdl_post_use_ix", using: :btree

  create_table "mdl_profiling", force: true do |t|
    t.string  "runid",              limit: 32,         default: "", null: false
    t.string  "url",                                   default: "", null: false
    t.text    "data",               limit: 2147483647,              null: false
    t.integer "totalexecutiontime", limit: 8,                       null: false
    t.integer "totalcputime",       limit: 8,                       null: false
    t.integer "totalcalls",         limit: 8,                       null: false
    t.integer "totalmemory",        limit: 8,                       null: false
    t.integer "runreference",       limit: 1,          default: 0,  null: false
    t.string  "runcomment",                            default: "", null: false
    t.integer "timecreated",        limit: 8,                       null: false
  end

  add_index "mdl_profiling", ["runid"], name: "mdl_prof_run_uix", unique: true, using: :btree
  add_index "mdl_profiling", ["timecreated", "runreference"], name: "mdl_prof_timrun_ix", using: :btree
  add_index "mdl_profiling", ["url", "runreference"], name: "mdl_prof_urlrun_ix", using: :btree

  create_table "mdl_qtype_essay_options", force: true do |t|
    t.integer "questionid",             limit: 8,                             null: false
    t.string  "responseformat",         limit: 16,         default: "editor", null: false
    t.integer "responsefieldlines",     limit: 2,          default: 15,       null: false
    t.integer "attachments",            limit: 2,          default: 0,        null: false
    t.text    "graderinfo",             limit: 2147483647
    t.integer "graderinfoformat",       limit: 2,          default: 0,        null: false
    t.text    "responsetemplate",       limit: 2147483647
    t.integer "responsetemplateformat", limit: 2,          default: 0,        null: false
  end

  add_index "mdl_qtype_essay_options", ["questionid"], name: "mdl_qtypessaopti_que_uix", unique: true, using: :btree

  create_table "mdl_qtype_match_options", force: true do |t|
    t.integer "questionid",                     limit: 8,          default: 0, null: false
    t.integer "shuffleanswers",                 limit: 2,          default: 1, null: false
    t.text    "correctfeedback",                limit: 2147483647,             null: false
    t.integer "correctfeedbackformat",          limit: 1,          default: 0, null: false
    t.text    "partiallycorrectfeedback",       limit: 2147483647,             null: false
    t.integer "partiallycorrectfeedbackformat", limit: 1,          default: 0, null: false
    t.text    "incorrectfeedback",              limit: 2147483647,             null: false
    t.integer "incorrectfeedbackformat",        limit: 1,          default: 0, null: false
    t.integer "shownumcorrect",                 limit: 1,          default: 0, null: false
  end

  add_index "mdl_qtype_match_options", ["questionid"], name: "mdl_qtypmatcopti_que_uix", unique: true, using: :btree

  create_table "mdl_qtype_match_subquestions", force: true do |t|
    t.integer "questionid",         limit: 8,          default: 0,  null: false
    t.text    "questiontext",       limit: 2147483647,              null: false
    t.integer "questiontextformat", limit: 1,          default: 0,  null: false
    t.string  "answertext",                            default: "", null: false
  end

  add_index "mdl_qtype_match_subquestions", ["questionid"], name: "mdl_qtypmatcsubq_que_ix", using: :btree

  create_table "mdl_qtype_multichoice_options", force: true do |t|
    t.integer "questionid",                     limit: 8,          default: 0,     null: false
    t.integer "layout",                         limit: 2,          default: 0,     null: false
    t.integer "single",                         limit: 2,          default: 0,     null: false
    t.integer "shuffleanswers",                 limit: 2,          default: 1,     null: false
    t.text    "correctfeedback",                limit: 2147483647,                 null: false
    t.integer "correctfeedbackformat",          limit: 1,          default: 0,     null: false
    t.text    "partiallycorrectfeedback",       limit: 2147483647,                 null: false
    t.integer "partiallycorrectfeedbackformat", limit: 1,          default: 0,     null: false
    t.text    "incorrectfeedback",              limit: 2147483647,                 null: false
    t.integer "incorrectfeedbackformat",        limit: 1,          default: 0,     null: false
    t.string  "answernumbering",                limit: 10,         default: "abc", null: false
    t.integer "shownumcorrect",                 limit: 1,          default: 0,     null: false
  end

  add_index "mdl_qtype_multichoice_options", ["questionid"], name: "mdl_qtypmultopti_que_uix", unique: true, using: :btree

  create_table "mdl_qtype_shortanswer_options", force: true do |t|
    t.integer "questionid", limit: 8, default: 0, null: false
    t.integer "usecase",    limit: 1, default: 0, null: false
  end

  add_index "mdl_qtype_shortanswer_options", ["questionid"], name: "mdl_quesshor_que_uix", unique: true, using: :btree

  create_table "mdl_question", force: true do |t|
    t.integer "category",              limit: 8,                                   default: 0,         null: false
    t.integer "parent",                limit: 8,                                   default: 0,         null: false
    t.string  "name",                                                              default: "",        null: false
    t.text    "questiontext",          limit: 2147483647,                                              null: false
    t.integer "questiontextformat",    limit: 1,                                   default: 0,         null: false
    t.text    "generalfeedback",       limit: 2147483647,                                              null: false
    t.integer "generalfeedbackformat", limit: 1,                                   default: 0,         null: false
    t.decimal "defaultmark",                              precision: 12, scale: 7, default: 1.0,       null: false
    t.decimal "penalty",                                  precision: 12, scale: 7, default: 0.3333333, null: false
    t.string  "qtype",                 limit: 20,                                  default: "",        null: false
    t.integer "length",                limit: 8,                                   default: 1,         null: false
    t.string  "stamp",                                                             default: "",        null: false
    t.string  "version",                                                           default: "",        null: false
    t.boolean "hidden",                                                            default: false,     null: false
    t.integer "timecreated",           limit: 8,                                   default: 0,         null: false
    t.integer "timemodified",          limit: 8,                                   default: 0,         null: false
    t.integer "createdby",             limit: 8
    t.integer "modifiedby",            limit: 8
  end

  add_index "mdl_question", ["category"], name: "mdl_ques_cat_ix", using: :btree
  add_index "mdl_question", ["createdby"], name: "mdl_ques_cre_ix", using: :btree
  add_index "mdl_question", ["modifiedby"], name: "mdl_ques_mod_ix", using: :btree
  add_index "mdl_question", ["parent"], name: "mdl_ques_par_ix", using: :btree

  create_table "mdl_question_answers", force: true do |t|
    t.integer "question",       limit: 8,                                   default: 0,   null: false
    t.text    "answer",         limit: 2147483647,                                        null: false
    t.integer "answerformat",   limit: 1,                                   default: 0,   null: false
    t.decimal "fraction",                          precision: 12, scale: 7, default: 0.0, null: false
    t.text    "feedback",       limit: 2147483647,                                        null: false
    t.integer "feedbackformat", limit: 1,                                   default: 0,   null: false
  end

  add_index "mdl_question_answers", ["question"], name: "mdl_quesansw_que_ix", using: :btree

  create_table "mdl_question_attempt_step_data", force: true do |t|
    t.integer "attemptstepid", limit: 8,                       null: false
    t.string  "name",          limit: 32,         default: "", null: false
    t.text    "value",         limit: 2147483647
  end

  add_index "mdl_question_attempt_step_data", ["attemptstepid", "name"], name: "mdl_quesattestepdata_attna_uix", unique: true, using: :btree
  add_index "mdl_question_attempt_step_data", ["attemptstepid"], name: "mdl_quesattestepdata_att_ix", using: :btree

  create_table "mdl_question_attempt_steps", force: true do |t|
    t.integer "questionattemptid", limit: 8,                                        null: false
    t.integer "sequencenumber",    limit: 8,                                        null: false
    t.string  "state",             limit: 13,                          default: "", null: false
    t.decimal "fraction",                     precision: 12, scale: 7
    t.integer "timecreated",       limit: 8,                                        null: false
    t.integer "userid",            limit: 8
  end

  add_index "mdl_question_attempt_steps", ["questionattemptid", "sequencenumber"], name: "mdl_quesattestep_queseq_uix", unique: true, using: :btree
  add_index "mdl_question_attempt_steps", ["questionattemptid"], name: "mdl_quesattestep_que_ix", using: :btree
  add_index "mdl_question_attempt_steps", ["userid"], name: "mdl_quesattestep_use_ix", using: :btree

  create_table "mdl_question_attempts", force: true do |t|
    t.integer "questionusageid", limit: 8,                                                   null: false
    t.integer "slot",            limit: 8,                                                   null: false
    t.string  "behaviour",       limit: 32,                                  default: "",    null: false
    t.integer "questionid",      limit: 8,                                                   null: false
    t.integer "variant",         limit: 8,                                   default: 1,     null: false
    t.decimal "maxmark",                            precision: 12, scale: 7,                 null: false
    t.decimal "minfraction",                        precision: 12, scale: 7,                 null: false
    t.decimal "maxfraction",                        precision: 12, scale: 7, default: 1.0,   null: false
    t.boolean "flagged",                                                     default: false, null: false
    t.text    "questionsummary", limit: 2147483647
    t.text    "rightanswer",     limit: 2147483647
    t.text    "responsesummary", limit: 2147483647
    t.integer "timemodified",    limit: 8,                                                   null: false
  end

  add_index "mdl_question_attempts", ["questionid"], name: "mdl_quesatte_que_ix", using: :btree
  add_index "mdl_question_attempts", ["questionusageid", "slot"], name: "mdl_quesatte_queslo_uix", unique: true, using: :btree
  add_index "mdl_question_attempts", ["questionusageid"], name: "mdl_quesatte_que2_ix", using: :btree

  create_table "mdl_question_calculated", force: true do |t|
    t.integer "question",            limit: 8,  default: 0,     null: false
    t.integer "answer",              limit: 8,  default: 0,     null: false
    t.string  "tolerance",           limit: 20, default: "0.0", null: false
    t.integer "tolerancetype",       limit: 8,  default: 1,     null: false
    t.integer "correctanswerlength", limit: 8,  default: 2,     null: false
    t.integer "correctanswerformat", limit: 8,  default: 2,     null: false
  end

  add_index "mdl_question_calculated", ["answer"], name: "mdl_quescalc_ans_ix", using: :btree
  add_index "mdl_question_calculated", ["question"], name: "mdl_quescalc_que_ix", using: :btree

  create_table "mdl_question_calculated_options", force: true do |t|
    t.integer "question",                       limit: 8,          default: 0,     null: false
    t.integer "synchronize",                    limit: 1,          default: 0,     null: false
    t.integer "single",                         limit: 2,          default: 0,     null: false
    t.integer "shuffleanswers",                 limit: 2,          default: 0,     null: false
    t.text    "correctfeedback",                limit: 2147483647
    t.integer "correctfeedbackformat",          limit: 1,          default: 0,     null: false
    t.text    "partiallycorrectfeedback",       limit: 2147483647
    t.integer "partiallycorrectfeedbackformat", limit: 1,          default: 0,     null: false
    t.text    "incorrectfeedback",              limit: 2147483647
    t.integer "incorrectfeedbackformat",        limit: 1,          default: 0,     null: false
    t.string  "answernumbering",                limit: 10,         default: "abc", null: false
    t.integer "shownumcorrect",                 limit: 1,          default: 0,     null: false
  end

  add_index "mdl_question_calculated_options", ["question"], name: "mdl_quescalcopti_que_ix", using: :btree

  create_table "mdl_question_categories", force: true do |t|
    t.string  "name",                          default: "",  null: false
    t.integer "contextid",  limit: 8,          default: 0,   null: false
    t.text    "info",       limit: 2147483647,               null: false
    t.integer "infoformat", limit: 1,          default: 0,   null: false
    t.string  "stamp",                         default: "",  null: false
    t.integer "parent",     limit: 8,          default: 0,   null: false
    t.integer "sortorder",  limit: 8,          default: 999, null: false
  end

  add_index "mdl_question_categories", ["contextid"], name: "mdl_quescate_con_ix", using: :btree
  add_index "mdl_question_categories", ["parent"], name: "mdl_quescate_par_ix", using: :btree

  create_table "mdl_question_dataset_definitions", force: true do |t|
    t.integer "category",  limit: 8, default: 0,  null: false
    t.string  "name",                default: "", null: false
    t.integer "type",      limit: 8, default: 0,  null: false
    t.string  "options",             default: "", null: false
    t.integer "itemcount", limit: 8, default: 0,  null: false
  end

  add_index "mdl_question_dataset_definitions", ["category"], name: "mdl_quesdatadefi_cat_ix", using: :btree

  create_table "mdl_question_dataset_items", force: true do |t|
    t.integer "definition", limit: 8, default: 0,  null: false
    t.integer "itemnumber", limit: 8, default: 0,  null: false
    t.string  "value",                default: "", null: false
  end

  add_index "mdl_question_dataset_items", ["definition"], name: "mdl_quesdataitem_def_ix", using: :btree

  create_table "mdl_question_datasets", force: true do |t|
    t.integer "question",          limit: 8, default: 0, null: false
    t.integer "datasetdefinition", limit: 8, default: 0, null: false
  end

  add_index "mdl_question_datasets", ["datasetdefinition"], name: "mdl_quesdata_dat_ix", using: :btree
  add_index "mdl_question_datasets", ["question", "datasetdefinition"], name: "mdl_quesdata_quedat_ix", using: :btree
  add_index "mdl_question_datasets", ["question"], name: "mdl_quesdata_que_ix", using: :btree

  create_table "mdl_question_hints", force: true do |t|
    t.integer "questionid",     limit: 8,                      null: false
    t.text    "hint",           limit: 2147483647,             null: false
    t.integer "hintformat",     limit: 2,          default: 0, null: false
    t.boolean "shownumcorrect"
    t.boolean "clearwrong"
    t.string  "options"
  end

  add_index "mdl_question_hints", ["questionid"], name: "mdl_queshint_que_ix", using: :btree

  create_table "mdl_question_multianswer", force: true do |t|
    t.integer "question", limit: 8,          default: 0, null: false
    t.text    "sequence", limit: 2147483647,             null: false
  end

  add_index "mdl_question_multianswer", ["question"], name: "mdl_quesmult_que_ix", using: :btree

  create_table "mdl_question_numerical", force: true do |t|
    t.integer "question",  limit: 8, default: 0,     null: false
    t.integer "answer",    limit: 8, default: 0,     null: false
    t.string  "tolerance",           default: "0.0", null: false
  end

  add_index "mdl_question_numerical", ["answer"], name: "mdl_quesnume_ans_ix", using: :btree
  add_index "mdl_question_numerical", ["question"], name: "mdl_quesnume_que_ix", using: :btree

  create_table "mdl_question_numerical_options", force: true do |t|
    t.integer "question",        limit: 8,                          default: 0,   null: false
    t.integer "showunits",       limit: 2,                          default: 0,   null: false
    t.integer "unitsleft",       limit: 2,                          default: 0,   null: false
    t.integer "unitgradingtype", limit: 2,                          default: 0,   null: false
    t.decimal "unitpenalty",               precision: 12, scale: 7, default: 0.1, null: false
  end

  add_index "mdl_question_numerical_options", ["question"], name: "mdl_quesnumeopti_que_ix", using: :btree

  create_table "mdl_question_numerical_units", force: true do |t|
    t.integer "question",   limit: 8,                            default: 0,   null: false
    t.decimal "multiplier",            precision: 40, scale: 20, default: 1.0, null: false
    t.string  "unit",       limit: 50,                           default: "",  null: false
  end

  add_index "mdl_question_numerical_units", ["question", "unit"], name: "mdl_quesnumeunit_queuni_uix", unique: true, using: :btree
  add_index "mdl_question_numerical_units", ["question"], name: "mdl_quesnumeunit_que_ix", using: :btree

  create_table "mdl_question_randomsamatch", force: true do |t|
    t.integer "question", limit: 8, default: 0, null: false
    t.integer "choose",   limit: 8, default: 4, null: false
  end

  add_index "mdl_question_randomsamatch", ["question"], name: "mdl_quesrand_que_ix", using: :btree

  create_table "mdl_question_response_analysis", force: true do |t|
    t.string  "hashcode",     limit: 40,                                  default: "", null: false
    t.integer "timemodified", limit: 8,                                                null: false
    t.integer "questionid",   limit: 8,                                                null: false
    t.string  "subqid",       limit: 100,                                 default: "", null: false
    t.string  "aid",          limit: 100
    t.text    "response",     limit: 2147483647
    t.integer "rcount",       limit: 8
    t.decimal "credit",                          precision: 15, scale: 5,              null: false
  end

  create_table "mdl_question_sessions", force: true do |t|
    t.integer "attemptid",           limit: 8,                                   default: 0,   null: false
    t.integer "questionid",          limit: 8,                                   default: 0,   null: false
    t.integer "newest",              limit: 8,                                   default: 0,   null: false
    t.integer "newgraded",           limit: 8,                                   default: 0,   null: false
    t.decimal "sumpenalty",                             precision: 12, scale: 7, default: 0.0, null: false
    t.text    "manualcomment",       limit: 2147483647,                                        null: false
    t.integer "manualcommentformat", limit: 1,                                   default: 0,   null: false
    t.integer "flagged",             limit: 1,                                   default: 0,   null: false
  end

  add_index "mdl_question_sessions", ["attemptid", "questionid"], name: "mdl_quessess_attque_uix", unique: true, using: :btree
  add_index "mdl_question_sessions", ["attemptid"], name: "mdl_quessess_att_ix", using: :btree
  add_index "mdl_question_sessions", ["newest"], name: "mdl_quessess_new_ix", using: :btree
  add_index "mdl_question_sessions", ["newgraded"], name: "mdl_quessess_new2_ix", using: :btree
  add_index "mdl_question_sessions", ["questionid"], name: "mdl_quessess_que_ix", using: :btree

  create_table "mdl_question_states", force: true do |t|
    t.integer "attempt",    limit: 8,                                   default: 0,   null: false
    t.integer "question",   limit: 8,                                   default: 0,   null: false
    t.integer "seq_number", limit: 3,                                   default: 0,   null: false
    t.text    "answer",     limit: 2147483647,                                        null: false
    t.integer "timestamp",  limit: 8,                                   default: 0,   null: false
    t.integer "event",      limit: 2,                                   default: 0,   null: false
    t.decimal "grade",                         precision: 12, scale: 7, default: 0.0, null: false
    t.decimal "raw_grade",                     precision: 12, scale: 7, default: 0.0, null: false
    t.decimal "penalty",                       precision: 12, scale: 7, default: 0.0, null: false
  end

  add_index "mdl_question_states", ["attempt"], name: "mdl_quesstat_att_ix", using: :btree
  add_index "mdl_question_states", ["question"], name: "mdl_quesstat_que_ix", using: :btree

  create_table "mdl_question_statistics", force: true do |t|
    t.string  "hashcode",                 limit: 40,                                   default: "", null: false
    t.integer "timemodified",             limit: 8,                                                 null: false
    t.integer "questionid",               limit: 8,                                                 null: false
    t.integer "slot",                     limit: 8
    t.integer "subquestion",              limit: 2,                                                 null: false
    t.integer "s",                        limit: 8,                                    default: 0,  null: false
    t.decimal "effectiveweight",                             precision: 15, scale: 5
    t.integer "negcovar",                 limit: 1,                                    default: 0,  null: false
    t.decimal "discriminationindex",                         precision: 15, scale: 5
    t.decimal "discriminativeefficiency",                    precision: 15, scale: 5
    t.decimal "sd",                                          precision: 15, scale: 10
    t.decimal "facility",                                    precision: 15, scale: 10
    t.text    "subquestions",             limit: 2147483647
    t.decimal "maxmark",                                     precision: 12, scale: 7
    t.text    "positions",                limit: 2147483647
    t.decimal "randomguessscore",                            precision: 12, scale: 7
  end

  create_table "mdl_question_truefalse", force: true do |t|
    t.integer "question",    limit: 8, default: 0, null: false
    t.integer "trueanswer",  limit: 8, default: 0, null: false
    t.integer "falseanswer", limit: 8, default: 0, null: false
  end

  add_index "mdl_question_truefalse", ["question"], name: "mdl_questrue_que_ix", using: :btree

  create_table "mdl_question_usages", force: true do |t|
    t.integer "contextid",          limit: 8,               null: false
    t.string  "component",                     default: "", null: false
    t.string  "preferredbehaviour", limit: 32, default: "", null: false
  end

  add_index "mdl_question_usages", ["contextid"], name: "mdl_quesusag_con_ix", using: :btree

  create_table "mdl_quiz", force: true do |t|
    t.integer "course",                 limit: 8,                                   default: 0,             null: false
    t.string  "name",                                                               default: "",            null: false
    t.text    "intro",                  limit: 2147483647,                                                  null: false
    t.integer "introformat",            limit: 2,                                   default: 0,             null: false
    t.integer "timeopen",               limit: 8,                                   default: 0,             null: false
    t.integer "timeclose",              limit: 8,                                   default: 0,             null: false
    t.string  "preferredbehaviour",     limit: 32,                                  default: "",            null: false
    t.integer "attempts",               limit: 3,                                   default: 0,             null: false
    t.integer "attemptonlast",          limit: 2,                                   default: 0,             null: false
    t.integer "grademethod",            limit: 2,                                   default: 1,             null: false
    t.integer "decimalpoints",          limit: 2,                                   default: 2,             null: false
    t.integer "questiondecimalpoints",  limit: 2,                                   default: -1,            null: false
    t.integer "reviewattempt",          limit: 3,                                   default: 0,             null: false
    t.integer "reviewcorrectness",      limit: 3,                                   default: 0,             null: false
    t.integer "reviewmarks",            limit: 3,                                   default: 0,             null: false
    t.integer "reviewspecificfeedback", limit: 3,                                   default: 0,             null: false
    t.integer "reviewgeneralfeedback",  limit: 3,                                   default: 0,             null: false
    t.integer "reviewrightanswer",      limit: 3,                                   default: 0,             null: false
    t.integer "reviewoverallfeedback",  limit: 3,                                   default: 0,             null: false
    t.integer "questionsperpage",       limit: 8,                                   default: 0,             null: false
    t.integer "shufflequestions",       limit: 2,                                   default: 0,             null: false
    t.integer "shuffleanswers",         limit: 2,                                   default: 0,             null: false
    t.text    "questions",              limit: 2147483647,                                                  null: false
    t.decimal "sumgrades",                                 precision: 10, scale: 5, default: 0.0,           null: false
    t.decimal "grade",                                     precision: 10, scale: 5, default: 0.0,           null: false
    t.integer "timecreated",            limit: 8,                                   default: 0,             null: false
    t.integer "timemodified",           limit: 8,                                   default: 0,             null: false
    t.integer "timelimit",              limit: 8,                                   default: 0,             null: false
    t.string  "overduehandling",        limit: 16,                                  default: "autoabandon", null: false
    t.integer "graceperiod",            limit: 8,                                   default: 0,             null: false
    t.string  "password",                                                           default: "",            null: false
    t.string  "subnet",                                                             default: "",            null: false
    t.string  "browsersecurity",        limit: 32,                                  default: "",            null: false
    t.integer "delay1",                 limit: 8,                                   default: 0,             null: false
    t.integer "delay2",                 limit: 8,                                   default: 0,             null: false
    t.integer "showuserpicture",        limit: 2,                                   default: 0,             null: false
    t.integer "showblocks",             limit: 2,                                   default: 0,             null: false
    t.string  "navmethod",              limit: 16,                                  default: "free",        null: false
  end

  add_index "mdl_quiz", ["course"], name: "mdl_quiz_cou_ix", using: :btree

  create_table "mdl_quiz_attempts", force: true do |t|
    t.integer "uniqueid",            limit: 8,                                   default: 0,            null: false
    t.integer "quiz",                limit: 8,                                   default: 0,            null: false
    t.integer "userid",              limit: 8,                                   default: 0,            null: false
    t.integer "attempt",             limit: 3,                                   default: 0,            null: false
    t.decimal "sumgrades",                              precision: 10, scale: 5
    t.integer "timestart",           limit: 8,                                   default: 0,            null: false
    t.integer "timefinish",          limit: 8,                                   default: 0,            null: false
    t.integer "timemodified",        limit: 8,                                   default: 0,            null: false
    t.integer "timecheckstate",      limit: 8,                                   default: 0
    t.text    "layout",              limit: 2147483647,                                                 null: false
    t.integer "preview",             limit: 2,                                   default: 0,            null: false
    t.string  "state",               limit: 16,                                  default: "inprogress", null: false
    t.integer "needsupgradetonewqe", limit: 2,                                   default: 0,            null: false
    t.integer "currentpage",         limit: 8,                                   default: 0,            null: false
  end

  add_index "mdl_quiz_attempts", ["quiz", "userid", "attempt"], name: "mdl_quizatte_quiuseatt_uix", unique: true, using: :btree
  add_index "mdl_quiz_attempts", ["quiz"], name: "mdl_quizatte_qui_ix", using: :btree
  add_index "mdl_quiz_attempts", ["state", "timecheckstate"], name: "mdl_quizatte_statim_ix", using: :btree
  add_index "mdl_quiz_attempts", ["uniqueid"], name: "mdl_quizatte_uni_uix", unique: true, using: :btree
  add_index "mdl_quiz_attempts", ["userid"], name: "mdl_quizatte_use_ix", using: :btree

  create_table "mdl_quiz_feedback", force: true do |t|
    t.integer "quizid",             limit: 8,                                   default: 0,   null: false
    t.text    "feedbacktext",       limit: 2147483647,                                        null: false
    t.integer "feedbacktextformat", limit: 1,                                   default: 0,   null: false
    t.decimal "mingrade",                              precision: 10, scale: 5, default: 0.0, null: false
    t.decimal "maxgrade",                              precision: 10, scale: 5, default: 0.0, null: false
  end

  add_index "mdl_quiz_feedback", ["quizid"], name: "mdl_quizfeed_qui_ix", using: :btree

  create_table "mdl_quiz_grades", force: true do |t|
    t.integer "quiz",         limit: 8,                          default: 0,   null: false
    t.integer "userid",       limit: 8,                          default: 0,   null: false
    t.decimal "grade",                  precision: 10, scale: 5, default: 0.0, null: false
    t.integer "timemodified", limit: 8,                          default: 0,   null: false
  end

  add_index "mdl_quiz_grades", ["quiz"], name: "mdl_quizgrad_qui_ix", using: :btree
  add_index "mdl_quiz_grades", ["userid"], name: "mdl_quizgrad_use_ix", using: :btree

  create_table "mdl_quiz_overrides", force: true do |t|
    t.integer "quiz",      limit: 8, default: 0, null: false
    t.integer "groupid",   limit: 8
    t.integer "userid",    limit: 8
    t.integer "timeopen",  limit: 8
    t.integer "timeclose", limit: 8
    t.integer "timelimit", limit: 8
    t.integer "attempts",  limit: 3
    t.string  "password"
  end

  add_index "mdl_quiz_overrides", ["groupid"], name: "mdl_quizover_gro_ix", using: :btree
  add_index "mdl_quiz_overrides", ["quiz"], name: "mdl_quizover_qui_ix", using: :btree
  add_index "mdl_quiz_overrides", ["userid"], name: "mdl_quizover_use_ix", using: :btree

  create_table "mdl_quiz_overview_regrades", force: true do |t|
    t.integer "questionusageid", limit: 8,                          null: false
    t.integer "slot",            limit: 8,                          null: false
    t.decimal "newfraction",               precision: 12, scale: 7
    t.decimal "oldfraction",               precision: 12, scale: 7
    t.integer "regraded",        limit: 2,                          null: false
    t.integer "timemodified",    limit: 8,                          null: false
  end

  create_table "mdl_quiz_question_instances", force: true do |t|
    t.integer "quiz",     limit: 8,                          default: 0,   null: false
    t.integer "question", limit: 8,                          default: 0,   null: false
    t.decimal "grade",              precision: 12, scale: 7, default: 0.0, null: false
  end

  add_index "mdl_quiz_question_instances", ["question"], name: "mdl_quizquesinst_que_ix", using: :btree
  add_index "mdl_quiz_question_instances", ["quiz"], name: "mdl_quizquesinst_qui_ix", using: :btree

  create_table "mdl_quiz_reports", force: true do |t|
    t.string  "name"
    t.integer "displayorder", limit: 8, null: false
    t.string  "capability"
  end

  add_index "mdl_quiz_reports", ["name"], name: "mdl_quizrepo_nam_uix", unique: true, using: :btree

  create_table "mdl_quiz_statistics", force: true do |t|
    t.string  "hashcode",             limit: 40,                           default: "", null: false
    t.integer "whichattempts",        limit: 2,                                         null: false
    t.integer "timemodified",         limit: 8,                                         null: false
    t.integer "firstattemptscount",   limit: 8,                                         null: false
    t.integer "highestattemptscount", limit: 8,                                         null: false
    t.integer "lastattemptscount",    limit: 8,                                         null: false
    t.integer "allattemptscount",     limit: 8,                                         null: false
    t.decimal "firstattemptsavg",                precision: 15, scale: 5
    t.decimal "highestattemptsavg",              precision: 15, scale: 5
    t.decimal "lastattemptsavg",                 precision: 15, scale: 5
    t.decimal "allattemptsavg",                  precision: 15, scale: 5
    t.decimal "median",                          precision: 15, scale: 5
    t.decimal "standarddeviation",               precision: 15, scale: 5
    t.decimal "skewness",                        precision: 15, scale: 10
    t.decimal "kurtosis",                        precision: 15, scale: 5
    t.decimal "cic",                             precision: 15, scale: 10
    t.decimal "errorratio",                      precision: 15, scale: 10
    t.decimal "standarderror",                   precision: 15, scale: 10
  end

  create_table "mdl_rating", force: true do |t|
    t.integer "contextid",    limit: 8,                null: false
    t.string  "component",    limit: 100, default: "", null: false
    t.string  "ratingarea",   limit: 50,  default: "", null: false
    t.integer "itemid",       limit: 8,                null: false
    t.integer "scaleid",      limit: 8,                null: false
    t.integer "rating",       limit: 8,                null: false
    t.integer "userid",       limit: 8,                null: false
    t.integer "timecreated",  limit: 8,                null: false
    t.integer "timemodified", limit: 8,                null: false
  end

  add_index "mdl_rating", ["component", "ratingarea", "contextid", "itemid"], name: "mdl_rati_comratconite2_ix", using: :btree
  add_index "mdl_rating", ["contextid"], name: "mdl_rati_con_ix", using: :btree
  add_index "mdl_rating", ["userid"], name: "mdl_rati_use_ix", using: :btree

  create_table "mdl_registration_hubs", force: true do |t|
    t.string  "token",     default: "",    null: false
    t.string  "hubname",   default: "",    null: false
    t.string  "huburl",    default: "",    null: false
    t.boolean "confirmed", default: false, null: false
    t.string  "secret"
  end

  create_table "mdl_repository", force: true do |t|
    t.string  "type",                default: "",   null: false
    t.boolean "visible",             default: true
    t.integer "sortorder", limit: 8, default: 0,    null: false
  end

  create_table "mdl_repository_file", force: true do |t|
    t.integer "version",                               default: 0,     null: false
    t.integer "folderid",                              default: 0,     null: false
    t.integer "refcount",                              default: 0,     null: false
    t.integer "type",                                  default: 0,     null: false
    t.string  "displayname",                           default: "",    null: false
    t.string  "lcname",                                default: "",    null: false
    t.text    "url",                limit: 2147483647,                 null: false
    t.integer "size",                                  default: 0,     null: false
    t.integer "previous_versionid",                    default: 0,     null: false
    t.integer "next_versionid",                        default: 0,     null: false
    t.boolean "trashed",                               default: false, null: false
    t.string  "keywords",                              default: "",    null: false
    t.integer "timecreated",                           default: 0,     null: false
    t.integer "timemodified",                          default: 0,     null: false
  end

  add_index "mdl_repository_file", ["displayname", "keywords"], name: "mdl_repository_file_dnamekeywords_ix", length: {"displayname"=>160, "keywords"=>160}, using: :btree
  add_index "mdl_repository_file", ["displayname"], name: "mdl_repository_file_displayname_ix", using: :btree
  add_index "mdl_repository_file", ["folderid", "type"], name: "mdl_repository_file_foldertype_ix", using: :btree
  add_index "mdl_repository_file", ["folderid"], name: "mdl_repository_file_folderid_ix", using: :btree
  add_index "mdl_repository_file", ["id", "next_versionid"], name: "mdl_repository_file_idnversion_ix", using: :btree
  add_index "mdl_repository_file", ["id", "previous_versionid"], name: "mdl_repository_file_idpversion_ix", using: :btree
  add_index "mdl_repository_file", ["id", "version"], name: "mdl_repository_file_idversion_ix", using: :btree
  add_index "mdl_repository_file", ["keywords"], name: "mdl_repository_file_keywords_ix", using: :btree
  add_index "mdl_repository_file", ["lcname", "keywords"], name: "mdl_repository_file_lcnamekeywords_ix", length: {"lcname"=>160, "keywords"=>160}, using: :btree
  add_index "mdl_repository_file", ["lcname"], name: "mdl_repository_file_lcname_ix", using: :btree
  add_index "mdl_repository_file", ["size"], name: "mdl_repository_file_size_ix", using: :btree
  add_index "mdl_repository_file", ["timecreated"], name: "mdl_repository_file_timecreated_ix", using: :btree
  add_index "mdl_repository_file", ["timemodified"], name: "mdl_repository_file_timemodified_ix", using: :btree
  add_index "mdl_repository_file", ["trashed"], name: "mdl_repository_file_trashed_ix", using: :btree

  create_table "mdl_repository_instance_config", force: true do |t|
    t.integer "instanceid", limit: 8,                       null: false
    t.string  "name",                          default: "", null: false
    t.text    "value",      limit: 2147483647
  end

  create_table "mdl_repository_instances", force: true do |t|
    t.string  "name",                   default: "",    null: false
    t.integer "typeid",       limit: 8,                 null: false
    t.integer "userid",       limit: 8, default: 0,     null: false
    t.integer "contextid",    limit: 8,                 null: false
    t.string  "username"
    t.string  "password"
    t.integer "timecreated",  limit: 8
    t.integer "timemodified", limit: 8
    t.boolean "readonly",               default: false, null: false
  end

  create_table "mdl_resource", force: true do |t|
    t.integer "course",          limit: 8,          default: 0,  null: false
    t.string  "name",                               default: "", null: false
    t.text    "intro",           limit: 2147483647
    t.integer "introformat",     limit: 2,          default: 0,  null: false
    t.integer "tobemigrated",    limit: 2,          default: 0,  null: false
    t.integer "legacyfiles",     limit: 2,          default: 0,  null: false
    t.integer "legacyfileslast", limit: 8
    t.integer "display",         limit: 2,          default: 0,  null: false
    t.text    "displayoptions",  limit: 2147483647
    t.integer "filterfiles",     limit: 2,          default: 0,  null: false
    t.integer "revision",        limit: 8,          default: 0,  null: false
    t.integer "timemodified",    limit: 8,          default: 0,  null: false
  end

  add_index "mdl_resource", ["course"], name: "mdl_reso_cou_ix", using: :btree

  create_table "mdl_resource_old", force: true do |t|
    t.integer "course",       limit: 8,          default: 0,  null: false
    t.string  "name",                            default: "", null: false
    t.string  "type",         limit: 30,         default: "", null: false
    t.string  "reference",                       default: "", null: false
    t.text    "intro",        limit: 2147483647
    t.integer "introformat",  limit: 2,          default: 0,  null: false
    t.text    "alltext",      limit: 2147483647,              null: false
    t.text    "popup",        limit: 2147483647,              null: false
    t.string  "options",                         default: "", null: false
    t.integer "timemodified", limit: 8,          default: 0,  null: false
    t.integer "oldid",        limit: 8,                       null: false
    t.integer "cmid",         limit: 8
    t.string  "newmodule",    limit: 50
    t.integer "newid",        limit: 8
    t.integer "migrated",     limit: 8,          default: 0,  null: false
  end

  add_index "mdl_resource_old", ["cmid"], name: "mdl_resoold_cmi_ix", using: :btree
  add_index "mdl_resource_old", ["oldid"], name: "mdl_resoold_old_uix", unique: true, using: :btree

  create_table "mdl_role", force: true do |t|
    t.string  "name",                           default: "", null: false
    t.string  "shortname",   limit: 100,        default: "", null: false
    t.text    "description", limit: 2147483647,              null: false
    t.integer "sortorder",   limit: 8,          default: 0,  null: false
    t.string  "archetype",   limit: 30,         default: "", null: false
  end

  add_index "mdl_role", ["shortname"], name: "mdl_role_sho_uix", unique: true, using: :btree
  add_index "mdl_role", ["sortorder"], name: "mdl_role_sor_uix", unique: true, using: :btree

  create_table "mdl_role_allow_assign", force: true do |t|
    t.integer "roleid",      limit: 8, default: 0, null: false
    t.integer "allowassign", limit: 8, default: 0, null: false
  end

  add_index "mdl_role_allow_assign", ["allowassign"], name: "mdl_rolealloassi_all_ix", using: :btree
  add_index "mdl_role_allow_assign", ["roleid", "allowassign"], name: "mdl_rolealloassi_rolall_uix", unique: true, using: :btree
  add_index "mdl_role_allow_assign", ["roleid"], name: "mdl_rolealloassi_rol_ix", using: :btree

  create_table "mdl_role_allow_override", force: true do |t|
    t.integer "roleid",        limit: 8, default: 0, null: false
    t.integer "allowoverride", limit: 8, default: 0, null: false
  end

  add_index "mdl_role_allow_override", ["allowoverride"], name: "mdl_rolealloover_all_ix", using: :btree
  add_index "mdl_role_allow_override", ["roleid", "allowoverride"], name: "mdl_rolealloover_rolall_uix", unique: true, using: :btree
  add_index "mdl_role_allow_override", ["roleid"], name: "mdl_rolealloover_rol_ix", using: :btree

  create_table "mdl_role_allow_switch", force: true do |t|
    t.integer "roleid",      limit: 8, null: false
    t.integer "allowswitch", limit: 8, null: false
  end

  add_index "mdl_role_allow_switch", ["allowswitch"], name: "mdl_rolealloswit_all_ix", using: :btree
  add_index "mdl_role_allow_switch", ["roleid", "allowswitch"], name: "mdl_rolealloswit_rolall_uix", unique: true, using: :btree
  add_index "mdl_role_allow_switch", ["roleid"], name: "mdl_rolealloswit_rol_ix", using: :btree

  create_table "mdl_role_assignments", force: true do |t|
    t.integer "roleid",       limit: 8,   default: 0,  null: false
    t.integer "contextid",    limit: 8,   default: 0,  null: false
    t.integer "userid",       limit: 8,   default: 0,  null: false
    t.integer "timemodified", limit: 8,   default: 0,  null: false
    t.integer "modifierid",   limit: 8,   default: 0,  null: false
    t.string  "component",    limit: 100, default: "", null: false
    t.integer "itemid",       limit: 8,   default: 0,  null: false
    t.integer "sortorder",    limit: 8,   default: 0,  null: false
  end

  add_index "mdl_role_assignments", ["component", "itemid", "userid"], name: "mdl_roleassi_comiteuse_ix", using: :btree
  add_index "mdl_role_assignments", ["contextid"], name: "mdl_roleassi_con_ix", using: :btree
  add_index "mdl_role_assignments", ["roleid", "contextid"], name: "mdl_roleassi_rolcon_ix", using: :btree
  add_index "mdl_role_assignments", ["roleid"], name: "mdl_roleassi_rol_ix", using: :btree
  add_index "mdl_role_assignments", ["sortorder"], name: "mdl_roleassi_sor_ix", using: :btree
  add_index "mdl_role_assignments", ["userid", "contextid", "roleid"], name: "mdl_roleassi_useconrol_ix", using: :btree
  add_index "mdl_role_assignments", ["userid"], name: "mdl_roleassi_use_ix", using: :btree

  create_table "mdl_role_capabilities", force: true do |t|
    t.integer "contextid",    limit: 8, default: 0,  null: false
    t.integer "roleid",       limit: 8, default: 0,  null: false
    t.string  "capability",             default: "", null: false
    t.integer "permission",   limit: 8, default: 0,  null: false
    t.integer "timemodified", limit: 8, default: 0,  null: false
    t.integer "modifierid",   limit: 8, default: 0,  null: false
  end

  add_index "mdl_role_capabilities", ["capability"], name: "mdl_rolecapa_cap_ix", using: :btree
  add_index "mdl_role_capabilities", ["contextid"], name: "mdl_rolecapa_con_ix", using: :btree
  add_index "mdl_role_capabilities", ["modifierid"], name: "mdl_rolecapa_mod_ix", using: :btree
  add_index "mdl_role_capabilities", ["roleid", "contextid", "capability"], name: "mdl_rolecapa_rolconcap_uix", unique: true, using: :btree
  add_index "mdl_role_capabilities", ["roleid"], name: "mdl_rolecapa_rol_ix", using: :btree

  create_table "mdl_role_context_levels", force: true do |t|
    t.integer "roleid",       limit: 8, null: false
    t.integer "contextlevel", limit: 8, null: false
  end

  add_index "mdl_role_context_levels", ["contextlevel", "roleid"], name: "mdl_rolecontleve_conrol_uix", unique: true, using: :btree
  add_index "mdl_role_context_levels", ["roleid"], name: "mdl_rolecontleve_rol_ix", using: :btree

  create_table "mdl_role_names", force: true do |t|
    t.integer "roleid",    limit: 8, default: 0,  null: false
    t.integer "contextid", limit: 8, default: 0,  null: false
    t.string  "name",                default: "", null: false
  end

  add_index "mdl_role_names", ["contextid"], name: "mdl_rolename_con_ix", using: :btree
  add_index "mdl_role_names", ["roleid", "contextid"], name: "mdl_rolename_rolcon_uix", unique: true, using: :btree
  add_index "mdl_role_names", ["roleid"], name: "mdl_rolename_rol_ix", using: :btree

  create_table "mdl_role_sortorder", force: true do |t|
    t.integer "userid",    limit: 8, null: false
    t.integer "roleid",    limit: 8, null: false
    t.integer "contextid", limit: 8, null: false
    t.integer "sortoder",  limit: 8, null: false
  end

  add_index "mdl_role_sortorder", ["contextid"], name: "mdl_rolesort_con_ix", using: :btree
  add_index "mdl_role_sortorder", ["roleid"], name: "mdl_rolesort_rol_ix", using: :btree
  add_index "mdl_role_sortorder", ["userid", "roleid", "contextid"], name: "mdl_rolesort_userolcon_uix", unique: true, using: :btree
  add_index "mdl_role_sortorder", ["userid"], name: "mdl_rolesort_use_ix", using: :btree

  create_table "mdl_scale", force: true do |t|
    t.integer "courseid",          limit: 8,          default: 0,  null: false
    t.integer "userid",            limit: 8,          default: 0,  null: false
    t.string  "name",                                 default: "", null: false
    t.text    "scale",             limit: 2147483647,              null: false
    t.text    "description",       limit: 2147483647,              null: false
    t.integer "descriptionformat", limit: 1,          default: 0,  null: false
    t.integer "timemodified",      limit: 8,          default: 0,  null: false
  end

  add_index "mdl_scale", ["courseid"], name: "mdl_scal_cou_ix", using: :btree

  create_table "mdl_scale_history", force: true do |t|
    t.integer "action",       limit: 8,          default: 0,  null: false
    t.integer "oldid",        limit: 8,                       null: false
    t.string  "source"
    t.integer "timemodified", limit: 8
    t.integer "loggeduser",   limit: 8
    t.integer "courseid",     limit: 8,          default: 0,  null: false
    t.integer "userid",       limit: 8,          default: 0,  null: false
    t.string  "name",                            default: "", null: false
    t.text    "scale",        limit: 2147483647,              null: false
    t.text    "description",  limit: 2147483647,              null: false
  end

  add_index "mdl_scale_history", ["action"], name: "mdl_scalhist_act_ix", using: :btree
  add_index "mdl_scale_history", ["courseid"], name: "mdl_scalhist_cou_ix", using: :btree
  add_index "mdl_scale_history", ["loggeduser"], name: "mdl_scalhist_log_ix", using: :btree
  add_index "mdl_scale_history", ["oldid"], name: "mdl_scalhist_old_ix", using: :btree

  create_table "mdl_scorm", force: true do |t|
    t.integer "course",                   limit: 8,          default: 0,       null: false
    t.string  "name",                                        default: "",      null: false
    t.string  "scormtype",                limit: 50,         default: "local", null: false
    t.string  "reference",                                   default: "",      null: false
    t.text    "intro",                    limit: 2147483647,                   null: false
    t.integer "introformat",              limit: 2,          default: 0,       null: false
    t.string  "version",                  limit: 9,          default: "",      null: false
    t.float   "maxgrade",                                    default: 0.0,     null: false
    t.integer "grademethod",              limit: 1,          default: 0,       null: false
    t.integer "whatgrade",                limit: 8,          default: 0,       null: false
    t.integer "maxattempt",               limit: 8,          default: 1,       null: false
    t.boolean "forcecompleted",                              default: true,    null: false
    t.boolean "forcenewattempt",                             default: false,   null: false
    t.boolean "lastattemptlock",                             default: false,   null: false
    t.boolean "displayattemptstatus",                        default: true,    null: false
    t.boolean "displaycoursestructure",                      default: true,    null: false
    t.boolean "updatefreq",                                  default: false,   null: false
    t.string  "sha1hash",                 limit: 40
    t.string  "md5hash",                  limit: 32,         default: "",      null: false
    t.integer "revision",                 limit: 8,          default: 0,       null: false
    t.integer "launch",                   limit: 8,          default: 0,       null: false
    t.boolean "skipview",                                    default: true,    null: false
    t.boolean "hidebrowse",                                  default: false,   null: false
    t.boolean "hidetoc",                                     default: false,   null: false
    t.boolean "nav",                                         default: true,    null: false
    t.integer "navpositionleft",          limit: 8,          default: -100
    t.integer "navpositiontop",           limit: 8,          default: -100
    t.boolean "auto",                                        default: false,   null: false
    t.boolean "popup",                                       default: false,   null: false
    t.string  "options",                                     default: "",      null: false
    t.integer "width",                    limit: 8,          default: 100,     null: false
    t.integer "height",                   limit: 8,          default: 600,     null: false
    t.integer "timeopen",                 limit: 8,          default: 0,       null: false
    t.integer "timeclose",                limit: 8,          default: 0,       null: false
    t.integer "timemodified",             limit: 8,          default: 0,       null: false
    t.boolean "completionstatusrequired"
    t.integer "completionscorerequired",  limit: 1
  end

  add_index "mdl_scorm", ["course"], name: "mdl_scor_cou_ix", using: :btree

  create_table "mdl_scorm_aicc_session", force: true do |t|
    t.integer "userid",       limit: 8,  default: 0,  null: false
    t.integer "scormid",      limit: 8,  default: 0,  null: false
    t.string  "hacpsession",             default: "", null: false
    t.integer "scoid",        limit: 8,  default: 0
    t.string  "scormmode",    limit: 50
    t.string  "scormstatus"
    t.integer "attempt",      limit: 8
    t.string  "lessonstatus"
    t.string  "sessiontime"
    t.integer "timecreated",  limit: 8,  default: 0,  null: false
    t.integer "timemodified", limit: 8,  default: 0,  null: false
  end

  add_index "mdl_scorm_aicc_session", ["scormid"], name: "mdl_scoraiccsess_sco_ix", using: :btree
  add_index "mdl_scorm_aicc_session", ["userid"], name: "mdl_scoraiccsess_use_ix", using: :btree

  create_table "mdl_scorm_scoes", force: true do |t|
    t.integer "scorm",        limit: 8,          default: 0,  null: false
    t.string  "manifest",                        default: "", null: false
    t.string  "organization",                    default: "", null: false
    t.string  "parent",                          default: "", null: false
    t.string  "identifier",                      default: "", null: false
    t.text    "launch",       limit: 2147483647,              null: false
    t.string  "scormtype",    limit: 5,          default: "", null: false
    t.string  "title",                           default: "", null: false
    t.integer "sortorder",    limit: 8,          default: 0,  null: false
  end

  add_index "mdl_scorm_scoes", ["scorm"], name: "mdl_scorscoe_sco_ix", using: :btree

  create_table "mdl_scorm_scoes_data", force: true do |t|
    t.integer "scoid", limit: 8,          default: 0,  null: false
    t.string  "name",                     default: "", null: false
    t.text    "value", limit: 2147483647,              null: false
  end

  add_index "mdl_scorm_scoes_data", ["scoid"], name: "mdl_scorscoedata_sco_ix", using: :btree

  create_table "mdl_scorm_scoes_track", force: true do |t|
    t.integer "userid",       limit: 8,          default: 0,  null: false
    t.integer "scormid",      limit: 8,          default: 0,  null: false
    t.integer "scoid",        limit: 8,          default: 0,  null: false
    t.integer "attempt",      limit: 8,          default: 1,  null: false
    t.string  "element",                         default: "", null: false
    t.text    "value",        limit: 2147483647,              null: false
    t.integer "timemodified", limit: 8,          default: 0,  null: false
  end

  add_index "mdl_scorm_scoes_track", ["element"], name: "mdl_scorscoetrac_ele_ix", using: :btree
  add_index "mdl_scorm_scoes_track", ["scoid"], name: "mdl_scorscoetrac_sco2_ix", using: :btree
  add_index "mdl_scorm_scoes_track", ["scormid"], name: "mdl_scorscoetrac_sco_ix", using: :btree
  add_index "mdl_scorm_scoes_track", ["userid", "scormid", "scoid", "attempt", "element"], name: "mdl_scorscoetrac_usescosco_uix", unique: true, using: :btree
  add_index "mdl_scorm_scoes_track", ["userid"], name: "mdl_scorscoetrac_use_ix", using: :btree

  create_table "mdl_scorm_seq_mapinfo", force: true do |t|
    t.integer "scoid",                  limit: 8, default: 0,     null: false
    t.integer "objectiveid",            limit: 8, default: 0,     null: false
    t.integer "targetobjectiveid",      limit: 8, default: 0,     null: false
    t.boolean "readsatisfiedstatus",              default: true,  null: false
    t.boolean "readnormalizedmeasure",            default: true,  null: false
    t.boolean "writesatisfiedstatus",             default: false, null: false
    t.boolean "writenormalizedmeasure",           default: false, null: false
  end

  add_index "mdl_scorm_seq_mapinfo", ["objectiveid"], name: "mdl_scorseqmapi_obj_ix", using: :btree
  add_index "mdl_scorm_seq_mapinfo", ["scoid", "id", "objectiveid"], name: "mdl_scorseqmapi_scoidobj_uix", unique: true, using: :btree
  add_index "mdl_scorm_seq_mapinfo", ["scoid"], name: "mdl_scorseqmapi_sco_ix", using: :btree

  create_table "mdl_scorm_seq_objective", force: true do |t|
    t.integer "scoid",                limit: 8,  default: 0,     null: false
    t.boolean "primaryobj",                      default: false, null: false
    t.string  "objectiveid",                     default: "",    null: false
    t.boolean "satisfiedbymeasure",              default: true,  null: false
    t.float   "minnormalizedmeasure", limit: 11, default: 0.0,   null: false
  end

  add_index "mdl_scorm_seq_objective", ["scoid", "id"], name: "mdl_scorseqobje_scoid_uix", unique: true, using: :btree
  add_index "mdl_scorm_seq_objective", ["scoid"], name: "mdl_scorseqobje_sco_ix", using: :btree

  create_table "mdl_scorm_seq_rolluprule", force: true do |t|
    t.integer "scoid",                limit: 8,  default: 0,     null: false
    t.string  "childactivityset",     limit: 15, default: "",    null: false
    t.integer "minimumcount",         limit: 8,  default: 0,     null: false
    t.float   "minimumpercent",       limit: 11, default: 0.0,   null: false
    t.string  "conditioncombination", limit: 3,  default: "all", null: false
    t.string  "action",               limit: 15, default: "",    null: false
  end

  add_index "mdl_scorm_seq_rolluprule", ["scoid", "id"], name: "mdl_scorseqroll_scoid_uix", unique: true, using: :btree
  add_index "mdl_scorm_seq_rolluprule", ["scoid"], name: "mdl_scorseqroll_sco_ix", using: :btree

  create_table "mdl_scorm_seq_rolluprulecond", force: true do |t|
    t.integer "scoid",        limit: 8,  default: 0,      null: false
    t.integer "rollupruleid", limit: 8,  default: 0,      null: false
    t.string  "operator",     limit: 5,  default: "noOp", null: false
    t.string  "cond",         limit: 25, default: "",     null: false
  end

  add_index "mdl_scorm_seq_rolluprulecond", ["rollupruleid"], name: "mdl_scorseqroll_rol_ix", using: :btree
  add_index "mdl_scorm_seq_rolluprulecond", ["scoid", "rollupruleid", "id"], name: "mdl_scorseqroll_scorolid_uix", unique: true, using: :btree
  add_index "mdl_scorm_seq_rolluprulecond", ["scoid"], name: "mdl_scorseqroll_sco2_ix", using: :btree

  create_table "mdl_scorm_seq_rulecond", force: true do |t|
    t.integer "scoid",              limit: 8,  default: 0,        null: false
    t.integer "ruleconditionsid",   limit: 8,  default: 0,        null: false
    t.string  "refrencedobjective",            default: "",       null: false
    t.float   "measurethreshold",   limit: 11, default: 0.0,      null: false
    t.string  "operator",           limit: 5,  default: "noOp",   null: false
    t.string  "cond",               limit: 30, default: "always", null: false
  end

  add_index "mdl_scorm_seq_rulecond", ["id", "scoid", "ruleconditionsid"], name: "mdl_scorseqrule_idscorul_uix", unique: true, using: :btree
  add_index "mdl_scorm_seq_rulecond", ["ruleconditionsid"], name: "mdl_scorseqrule_rul_ix", using: :btree
  add_index "mdl_scorm_seq_rulecond", ["scoid"], name: "mdl_scorseqrule_sco2_ix", using: :btree

  create_table "mdl_scorm_seq_ruleconds", force: true do |t|
    t.integer "scoid",                limit: 8,  default: 0,     null: false
    t.string  "conditioncombination", limit: 3,  default: "all", null: false
    t.integer "ruletype",             limit: 1,  default: 0,     null: false
    t.string  "action",               limit: 25, default: "",    null: false
  end

  add_index "mdl_scorm_seq_ruleconds", ["scoid", "id"], name: "mdl_scorseqrule_scoid_uix", unique: true, using: :btree
  add_index "mdl_scorm_seq_ruleconds", ["scoid"], name: "mdl_scorseqrule_sco_ix", using: :btree

  create_table "mdl_sessions", force: true do |t|
    t.integer "state",        limit: 8,          default: 0,  null: false
    t.string  "sid",          limit: 128,        default: "", null: false
    t.integer "userid",       limit: 8,                       null: false
    t.text    "sessdata",     limit: 2147483647
    t.integer "timecreated",  limit: 8,                       null: false
    t.integer "timemodified", limit: 8,                       null: false
    t.string  "firstip",      limit: 45
    t.string  "lastip",       limit: 45
  end

  add_index "mdl_sessions", ["sid"], name: "mdl_sess_sid_uix", unique: true, using: :btree
  add_index "mdl_sessions", ["state"], name: "mdl_sess_sta_ix", using: :btree
  add_index "mdl_sessions", ["timecreated"], name: "mdl_sess_tim_ix", using: :btree
  add_index "mdl_sessions", ["timemodified"], name: "mdl_sess_tim2_ix", using: :btree
  add_index "mdl_sessions", ["userid"], name: "mdl_sess_use_ix", using: :btree

  create_table "mdl_stats_daily", force: true do |t|
    t.integer "courseid", limit: 8,  default: 0,          null: false
    t.integer "timeend",  limit: 8,  default: 0,          null: false
    t.integer "roleid",   limit: 8,  default: 0,          null: false
    t.string  "stattype", limit: 20, default: "activity", null: false
    t.integer "stat1",    limit: 8,  default: 0,          null: false
    t.integer "stat2",    limit: 8,  default: 0,          null: false
  end

  add_index "mdl_stats_daily", ["courseid"], name: "mdl_statdail_cou_ix", using: :btree
  add_index "mdl_stats_daily", ["roleid"], name: "mdl_statdail_rol_ix", using: :btree
  add_index "mdl_stats_daily", ["timeend"], name: "mdl_statdail_tim_ix", using: :btree

  create_table "mdl_stats_monthly", force: true do |t|
    t.integer "courseid", limit: 8,  default: 0,          null: false
    t.integer "timeend",  limit: 8,  default: 0,          null: false
    t.integer "roleid",   limit: 8,  default: 0,          null: false
    t.string  "stattype", limit: 20, default: "activity", null: false
    t.integer "stat1",    limit: 8,  default: 0,          null: false
    t.integer "stat2",    limit: 8,  default: 0,          null: false
  end

  add_index "mdl_stats_monthly", ["courseid"], name: "mdl_statmont_cou_ix", using: :btree
  add_index "mdl_stats_monthly", ["roleid"], name: "mdl_statmont_rol_ix", using: :btree
  add_index "mdl_stats_monthly", ["timeend"], name: "mdl_statmont_tim_ix", using: :btree

  create_table "mdl_stats_user_daily", force: true do |t|
    t.integer "courseid",    limit: 8,  default: 0,  null: false
    t.integer "userid",      limit: 8,  default: 0,  null: false
    t.integer "roleid",      limit: 8,  default: 0,  null: false
    t.integer "timeend",     limit: 8,  default: 0,  null: false
    t.integer "statsreads",  limit: 8,  default: 0,  null: false
    t.integer "statswrites", limit: 8,  default: 0,  null: false
    t.string  "stattype",    limit: 30, default: "", null: false
  end

  add_index "mdl_stats_user_daily", ["courseid"], name: "mdl_statuserdail_cou_ix", using: :btree
  add_index "mdl_stats_user_daily", ["roleid"], name: "mdl_statuserdail_rol_ix", using: :btree
  add_index "mdl_stats_user_daily", ["timeend"], name: "mdl_statuserdail_tim_ix", using: :btree
  add_index "mdl_stats_user_daily", ["userid"], name: "mdl_statuserdail_use_ix", using: :btree

  create_table "mdl_stats_user_monthly", force: true do |t|
    t.integer "courseid",    limit: 8,  default: 0,  null: false
    t.integer "userid",      limit: 8,  default: 0,  null: false
    t.integer "roleid",      limit: 8,  default: 0,  null: false
    t.integer "timeend",     limit: 8,  default: 0,  null: false
    t.integer "statsreads",  limit: 8,  default: 0,  null: false
    t.integer "statswrites", limit: 8,  default: 0,  null: false
    t.string  "stattype",    limit: 30, default: "", null: false
  end

  add_index "mdl_stats_user_monthly", ["courseid"], name: "mdl_statusermont_cou_ix", using: :btree
  add_index "mdl_stats_user_monthly", ["roleid"], name: "mdl_statusermont_rol_ix", using: :btree
  add_index "mdl_stats_user_monthly", ["timeend"], name: "mdl_statusermont_tim_ix", using: :btree
  add_index "mdl_stats_user_monthly", ["userid"], name: "mdl_statusermont_use_ix", using: :btree

  create_table "mdl_stats_user_weekly", force: true do |t|
    t.integer "courseid",    limit: 8,  default: 0,  null: false
    t.integer "userid",      limit: 8,  default: 0,  null: false
    t.integer "roleid",      limit: 8,  default: 0,  null: false
    t.integer "timeend",     limit: 8,  default: 0,  null: false
    t.integer "statsreads",  limit: 8,  default: 0,  null: false
    t.integer "statswrites", limit: 8,  default: 0,  null: false
    t.string  "stattype",    limit: 30, default: "", null: false
  end

  add_index "mdl_stats_user_weekly", ["courseid"], name: "mdl_statuserweek_cou_ix", using: :btree
  add_index "mdl_stats_user_weekly", ["roleid"], name: "mdl_statuserweek_rol_ix", using: :btree
  add_index "mdl_stats_user_weekly", ["timeend"], name: "mdl_statuserweek_tim_ix", using: :btree
  add_index "mdl_stats_user_weekly", ["userid"], name: "mdl_statuserweek_use_ix", using: :btree

  create_table "mdl_stats_weekly", force: true do |t|
    t.integer "courseid", limit: 8,  default: 0,          null: false
    t.integer "timeend",  limit: 8,  default: 0,          null: false
    t.integer "roleid",   limit: 8,  default: 0,          null: false
    t.string  "stattype", limit: 20, default: "activity", null: false
    t.integer "stat1",    limit: 8,  default: 0,          null: false
    t.integer "stat2",    limit: 8,  default: 0,          null: false
  end

  add_index "mdl_stats_weekly", ["courseid"], name: "mdl_statweek_cou_ix", using: :btree
  add_index "mdl_stats_weekly", ["roleid"], name: "mdl_statweek_rol_ix", using: :btree
  add_index "mdl_stats_weekly", ["timeend"], name: "mdl_statweek_tim_ix", using: :btree

  create_table "mdl_survey", force: true do |t|
    t.integer "course",       limit: 8,          default: 0,  null: false
    t.integer "template",     limit: 8,          default: 0,  null: false
    t.integer "days",         limit: 3,          default: 0,  null: false
    t.integer "timecreated",  limit: 8,          default: 0,  null: false
    t.integer "timemodified", limit: 8,          default: 0,  null: false
    t.string  "name",                            default: "", null: false
    t.text    "intro",        limit: 2147483647,              null: false
    t.integer "introformat",  limit: 2,          default: 0,  null: false
    t.string  "questions",                       default: "", null: false
  end

  add_index "mdl_survey", ["course"], name: "mdl_surv_cou_ix", using: :btree

  create_table "mdl_survey_analysis", force: true do |t|
    t.integer "survey", limit: 8,          default: 0, null: false
    t.integer "userid", limit: 8,          default: 0, null: false
    t.text    "notes",  limit: 2147483647,             null: false
  end

  add_index "mdl_survey_analysis", ["survey"], name: "mdl_survanal_sur_ix", using: :btree
  add_index "mdl_survey_analysis", ["userid"], name: "mdl_survanal_use_ix", using: :btree

  create_table "mdl_survey_answers", force: true do |t|
    t.integer "userid",   limit: 8,          default: 0, null: false
    t.integer "survey",   limit: 8,          default: 0, null: false
    t.integer "question", limit: 8,          default: 0, null: false
    t.integer "time",     limit: 8,          default: 0, null: false
    t.text    "answer1",  limit: 2147483647,             null: false
    t.text    "answer2",  limit: 2147483647,             null: false
  end

  add_index "mdl_survey_answers", ["question"], name: "mdl_survansw_que_ix", using: :btree
  add_index "mdl_survey_answers", ["survey"], name: "mdl_survansw_sur_ix", using: :btree
  add_index "mdl_survey_answers", ["userid"], name: "mdl_survansw_use_ix", using: :btree

  create_table "mdl_survey_questions", force: true do |t|
    t.string  "text",                         default: "", null: false
    t.string  "shorttext", limit: 30,         default: "", null: false
    t.string  "multi",     limit: 100,        default: "", null: false
    t.string  "intro",     limit: 50,         default: "", null: false
    t.integer "type",      limit: 2,          default: 0,  null: false
    t.text    "options",   limit: 2147483647
  end

  create_table "mdl_tag", force: true do |t|
    t.integer "userid",            limit: 8,                       null: false
    t.string  "name",                                 default: "", null: false
    t.string  "rawname",                              default: "", null: false
    t.string  "tagtype"
    t.text    "description",       limit: 2147483647
    t.integer "descriptionformat", limit: 1,          default: 0,  null: false
    t.integer "flag",              limit: 2,          default: 0
    t.integer "timemodified",      limit: 8
  end

  add_index "mdl_tag", ["id", "name"], name: "mdl_tag_idnam_uix", unique: true, using: :btree
  add_index "mdl_tag", ["name"], name: "mdl_tag_nam_uix", unique: true, using: :btree
  add_index "mdl_tag", ["userid"], name: "mdl_tag_use_ix", using: :btree

  create_table "mdl_tag_correlation", force: true do |t|
    t.integer "tagid",          limit: 8,          null: false
    t.text    "correlatedtags", limit: 2147483647, null: false
  end

  add_index "mdl_tag_correlation", ["tagid"], name: "mdl_tagcorr_tag_ix", using: :btree

  create_table "mdl_tag_instance", force: true do |t|
    t.integer "tagid",        limit: 8,              null: false
    t.string  "itemtype",               default: "", null: false
    t.integer "itemid",       limit: 8,              null: false
    t.integer "tiuserid",     limit: 8, default: 0,  null: false
    t.integer "ordering",     limit: 8
    t.integer "timemodified", limit: 8, default: 0,  null: false
  end

  add_index "mdl_tag_instance", ["itemtype", "itemid", "tagid", "tiuserid"], name: "mdl_taginst_iteitetagtiu2_uix", unique: true, using: :btree
  add_index "mdl_tag_instance", ["tagid"], name: "mdl_taginst_tag_ix", using: :btree

  create_table "mdl_timezone", force: true do |t|
    t.string  "name",          limit: 100, default: "",      null: false
    t.integer "year",          limit: 8,   default: 0,       null: false
    t.string  "tzrule",        limit: 20,  default: "",      null: false
    t.integer "gmtoff",        limit: 8,   default: 0,       null: false
    t.integer "dstoff",        limit: 8,   default: 0,       null: false
    t.integer "dst_month",     limit: 1,   default: 0,       null: false
    t.integer "dst_startday",  limit: 2,   default: 0,       null: false
    t.integer "dst_weekday",   limit: 2,   default: 0,       null: false
    t.integer "dst_skipweeks", limit: 2,   default: 0,       null: false
    t.string  "dst_time",      limit: 6,   default: "00:00", null: false
    t.integer "std_month",     limit: 1,   default: 0,       null: false
    t.integer "std_startday",  limit: 2,   default: 0,       null: false
    t.integer "std_weekday",   limit: 2,   default: 0,       null: false
    t.integer "std_skipweeks", limit: 2,   default: 0,       null: false
    t.string  "std_time",      limit: 6,   default: "00:00", null: false
  end

  create_table "mdl_tool_customlang", force: true do |t|
    t.string  "lang",           limit: 20,         default: "", null: false
    t.integer "componentid",    limit: 8,                       null: false
    t.string  "stringid",                          default: "", null: false
    t.text    "original",       limit: 2147483647,              null: false
    t.text    "master",         limit: 2147483647
    t.text    "local",          limit: 2147483647
    t.integer "timemodified",   limit: 8,                       null: false
    t.integer "timecustomized", limit: 8
    t.integer "outdated",       limit: 2,          default: 0
    t.integer "modified",       limit: 2,          default: 0
  end

  add_index "mdl_tool_customlang", ["componentid"], name: "mdl_toolcust_com_ix", using: :btree
  add_index "mdl_tool_customlang", ["lang", "componentid", "stringid"], name: "mdl_toolcust_lancomstr_uix", unique: true, using: :btree

  create_table "mdl_tool_customlang_components", force: true do |t|
    t.string "name",    default: "", null: false
    t.string "version"
  end

  create_table "mdl_upgrade_log", force: true do |t|
    t.integer "type",          limit: 8,                       null: false
    t.string  "plugin",        limit: 100
    t.string  "version",       limit: 100
    t.string  "targetversion", limit: 100
    t.string  "info",                             default: "", null: false
    t.text    "details",       limit: 2147483647
    t.text    "backtrace",     limit: 2147483647
    t.integer "userid",        limit: 8,                       null: false
    t.integer "timemodified",  limit: 8,                       null: false
  end

  add_index "mdl_upgrade_log", ["timemodified"], name: "mdl_upgrlog_tim_ix", using: :btree
  add_index "mdl_upgrade_log", ["type", "timemodified"], name: "mdl_upgrlog_typtim_ix", using: :btree
  add_index "mdl_upgrade_log", ["userid"], name: "mdl_upgrlog_use_ix", using: :btree

  create_table "mdl_url", force: true do |t|
    t.integer "course",         limit: 8,          default: 0,  null: false
    t.string  "name",                              default: "", null: false
    t.text    "intro",          limit: 2147483647
    t.integer "introformat",    limit: 2,          default: 0,  null: false
    t.text    "externalurl",    limit: 2147483647,              null: false
    t.integer "display",        limit: 2,          default: 0,  null: false
    t.text    "displayoptions", limit: 2147483647
    t.text    "parameters",     limit: 2147483647
    t.integer "timemodified",   limit: 8,          default: 0,  null: false
  end

  add_index "mdl_url", ["course"], name: "mdl_url_cou_ix", using: :btree

  create_table "mdl_user", force: true do |t|
    t.string  "auth",              limit: 20,         default: "manual",    null: false
    t.boolean "confirmed",                            default: false,       null: false
    t.boolean "policyagreed",                         default: false,       null: false
    t.boolean "deleted",                              default: false,       null: false
    t.boolean "suspended",                            default: false,       null: false
    t.integer "mnethostid",        limit: 8,          default: 0,           null: false
    t.string  "username",          limit: 100,        default: "",          null: false
    t.string  "password",                             default: "",          null: false
    t.string  "idnumber",                             default: "",          null: false
    t.string  "firstname",         limit: 100,        default: "",          null: false
    t.string  "lastname",          limit: 100,        default: "",          null: false
    t.string  "email",             limit: 100,        default: "",          null: false
    t.boolean "emailstop",                            default: false,       null: false
    t.string  "icq",               limit: 15,         default: "",          null: false
    t.string  "skype",             limit: 50,         default: "",          null: false
    t.string  "yahoo",             limit: 50,         default: "",          null: false
    t.string  "aim",               limit: 50,         default: "",          null: false
    t.string  "msn",               limit: 50,         default: "",          null: false
    t.string  "phone1",            limit: 20,         default: "",          null: false
    t.string  "phone2",            limit: 20,         default: "",          null: false
    t.string  "institution",                          default: "",          null: false
    t.string  "department",                           default: "",          null: false
    t.string  "address",                              default: "",          null: false
    t.string  "city",              limit: 120,        default: "",          null: false
    t.string  "country",           limit: 2,          default: "",          null: false
    t.string  "lang",              limit: 30,         default: "en",        null: false
    t.string  "theme",             limit: 50,         default: "",          null: false
    t.string  "timezone",          limit: 100,        default: "99",        null: false
    t.integer "firstaccess",       limit: 8,          default: 0,           null: false
    t.integer "lastaccess",        limit: 8,          default: 0,           null: false
    t.integer "lastlogin",         limit: 8,          default: 0,           null: false
    t.integer "currentlogin",      limit: 8,          default: 0,           null: false
    t.string  "lastip",            limit: 45,         default: "",          null: false
    t.string  "secret",            limit: 15,         default: "",          null: false
    t.integer "picture",           limit: 8,          default: 0,           null: false
    t.string  "url",                                  default: "",          null: false
    t.text    "description",       limit: 2147483647
    t.integer "descriptionformat", limit: 1,          default: 1,           null: false
    t.boolean "mailformat",                           default: true,        null: false
    t.boolean "maildigest",                           default: false,       null: false
    t.integer "maildisplay",       limit: 1,          default: 2,           null: false
    t.boolean "autosubscribe",                        default: true,        null: false
    t.boolean "trackforums",                          default: false,       null: false
    t.integer "timecreated",       limit: 8,          default: 0,           null: false
    t.integer "timemodified",      limit: 8,          default: 0,           null: false
    t.integer "trustbitmask",      limit: 8,          default: 0,           null: false
    t.string  "imagealt"
    t.string  "lastnamephonetic"
    t.string  "firstnamephonetic"
    t.string  "middlename"
    t.string  "alternatename"
    t.string  "calendartype",      limit: 30,         default: "gregorian", null: false
  end

  add_index "mdl_user", ["alternatename"], name: "mdl_user_alt_ix", using: :btree
  add_index "mdl_user", ["auth"], name: "mdl_user_aut_ix", using: :btree
  add_index "mdl_user", ["city"], name: "mdl_user_cit_ix", using: :btree
  add_index "mdl_user", ["confirmed"], name: "mdl_user_con_ix", using: :btree
  add_index "mdl_user", ["country"], name: "mdl_user_cou_ix", using: :btree
  add_index "mdl_user", ["deleted"], name: "mdl_user_del_ix", using: :btree
  add_index "mdl_user", ["email"], name: "mdl_user_ema_ix", using: :btree
  add_index "mdl_user", ["firstname"], name: "mdl_user_fir_ix", using: :btree
  add_index "mdl_user", ["firstnamephonetic"], name: "mdl_user_fir2_ix", using: :btree
  add_index "mdl_user", ["idnumber"], name: "mdl_user_idn_ix", using: :btree
  add_index "mdl_user", ["lastaccess"], name: "mdl_user_las2_ix", using: :btree
  add_index "mdl_user", ["lastname"], name: "mdl_user_las_ix", using: :btree
  add_index "mdl_user", ["lastnamephonetic"], name: "mdl_user_las3_ix", using: :btree
  add_index "mdl_user", ["middlename"], name: "mdl_user_mid_ix", using: :btree
  add_index "mdl_user", ["mnethostid", "username"], name: "mdl_user_mneuse_uix", unique: true, using: :btree

  create_table "mdl_user_devices", force: true do |t|
    t.integer "userid",       limit: 8,   default: 0,  null: false
    t.string  "appid",        limit: 128, default: "", null: false
    t.string  "name",         limit: 32,  default: "", null: false
    t.string  "model",        limit: 32,  default: "", null: false
    t.string  "platform",     limit: 32,  default: "", null: false
    t.string  "version",      limit: 32,  default: "", null: false
    t.string  "pushid",                   default: "", null: false
    t.string  "uuid",                     default: "", null: false
    t.integer "timecreated",  limit: 8,                null: false
    t.integer "timemodified", limit: 8,                null: false
  end

  add_index "mdl_user_devices", ["pushid", "platform"], name: "mdl_userdevi_puspla_uix", unique: true, using: :btree
  add_index "mdl_user_devices", ["pushid", "userid"], name: "mdl_userdevi_pususe_uix", unique: true, using: :btree
  add_index "mdl_user_devices", ["userid"], name: "mdl_userdevi_use_ix", using: :btree

  create_table "mdl_user_enrolments", force: true do |t|
    t.integer "status",       limit: 8, default: 0,          null: false
    t.integer "enrolid",      limit: 8,                      null: false
    t.integer "userid",       limit: 8,                      null: false
    t.integer "timestart",    limit: 8, default: 0,          null: false
    t.integer "timeend",      limit: 8, default: 2147483647, null: false
    t.integer "modifierid",   limit: 8, default: 0,          null: false
    t.integer "timecreated",  limit: 8, default: 0,          null: false
    t.integer "timemodified", limit: 8, default: 0,          null: false
  end

  add_index "mdl_user_enrolments", ["enrolid", "userid"], name: "mdl_userenro_enruse_uix", unique: true, using: :btree
  add_index "mdl_user_enrolments", ["enrolid"], name: "mdl_userenro_enr_ix", using: :btree
  add_index "mdl_user_enrolments", ["modifierid"], name: "mdl_userenro_mod_ix", using: :btree
  add_index "mdl_user_enrolments", ["userid"], name: "mdl_userenro_use_ix", using: :btree

  create_table "mdl_user_info_category", force: true do |t|
    t.string  "name",                default: "", null: false
    t.integer "sortorder", limit: 8, default: 0,  null: false
  end

  create_table "mdl_user_info_data", force: true do |t|
    t.integer "userid",     limit: 8,          default: 0, null: false
    t.integer "fieldid",    limit: 8,          default: 0, null: false
    t.text    "data",       limit: 2147483647,             null: false
    t.integer "dataformat", limit: 1,          default: 0, null: false
  end

  add_index "mdl_user_info_data", ["userid", "fieldid"], name: "mdl_userinfodata_usefie_ix", using: :btree

  create_table "mdl_user_info_field", force: true do |t|
    t.string  "shortname",                            default: "shortname", null: false
    t.text    "name",              limit: 2147483647,                       null: false
    t.string  "datatype",                             default: "",          null: false
    t.text    "description",       limit: 2147483647
    t.integer "descriptionformat", limit: 1,          default: 0,           null: false
    t.integer "categoryid",        limit: 8,          default: 0,           null: false
    t.integer "sortorder",         limit: 8,          default: 0,           null: false
    t.integer "required",          limit: 1,          default: 0,           null: false
    t.integer "locked",            limit: 1,          default: 0,           null: false
    t.integer "visible",           limit: 2,          default: 0,           null: false
    t.integer "forceunique",       limit: 1,          default: 0,           null: false
    t.integer "signup",            limit: 1,          default: 0,           null: false
    t.text    "defaultdata",       limit: 2147483647
    t.integer "defaultdataformat", limit: 1,          default: 0,           null: false
    t.text    "param1",            limit: 2147483647
    t.text    "param2",            limit: 2147483647
    t.text    "param3",            limit: 2147483647
    t.text    "param4",            limit: 2147483647
    t.text    "param5",            limit: 2147483647
  end

  create_table "mdl_user_lastaccess", force: true do |t|
    t.integer "userid",     limit: 8, default: 0, null: false
    t.integer "courseid",   limit: 8, default: 0, null: false
    t.integer "timeaccess", limit: 8, default: 0, null: false
  end

  add_index "mdl_user_lastaccess", ["courseid"], name: "mdl_userlast_cou_ix", using: :btree
  add_index "mdl_user_lastaccess", ["userid", "courseid"], name: "mdl_userlast_usecou_uix", unique: true, using: :btree
  add_index "mdl_user_lastaccess", ["userid"], name: "mdl_userlast_use_ix", using: :btree

  create_table "mdl_user_password_resets", force: true do |t|
    t.integer "userid",          limit: 8,               null: false
    t.integer "timerequested",   limit: 8,               null: false
    t.integer "timererequested", limit: 8,  default: 0,  null: false
    t.string  "token",           limit: 32, default: "", null: false
  end

  add_index "mdl_user_password_resets", ["userid"], name: "mdl_userpassrese_use_ix", using: :btree

  create_table "mdl_user_preferences", force: true do |t|
    t.integer "userid", limit: 8,    default: 0,  null: false
    t.string  "name",                default: "", null: false
    t.string  "value",  limit: 1333, default: "", null: false
  end

  add_index "mdl_user_preferences", ["userid", "name"], name: "mdl_userpref_usenam_uix", unique: true, using: :btree

  create_table "mdl_user_private_key", force: true do |t|
    t.string  "script",        limit: 128, default: "", null: false
    t.string  "value",         limit: 128, default: "", null: false
    t.integer "userid",        limit: 8,                null: false
    t.integer "instance",      limit: 8
    t.string  "iprestriction"
    t.integer "validuntil",    limit: 8
    t.integer "timecreated",   limit: 8
  end

  add_index "mdl_user_private_key", ["script", "value"], name: "mdl_userprivkey_scrval_ix", using: :btree
  add_index "mdl_user_private_key", ["userid"], name: "mdl_userprivkey_use_ix", using: :btree

  create_table "mdl_webdav_locks", force: true do |t|
    t.string  "token",                   default: "",    null: false
    t.string  "path",                    default: "",    null: false
    t.integer "expiry",        limit: 8, default: 0,     null: false
    t.integer "userid",        limit: 8, default: 0,     null: false
    t.boolean "recursive",               default: false, null: false
    t.boolean "exclusivelock",           default: false, null: false
    t.integer "created",       limit: 8, default: 0,     null: false
    t.integer "modified",      limit: 8, default: 0,     null: false
    t.string  "owner"
  end

  add_index "mdl_webdav_locks", ["expiry"], name: "mdl_webdlock_exp_ix", using: :btree
  add_index "mdl_webdav_locks", ["path"], name: "mdl_webdlock_pat_ix", using: :btree
  add_index "mdl_webdav_locks", ["token"], name: "mdl_webdlock_tok_uix", unique: true, using: :btree

  create_table "mdl_wiki", force: true do |t|
    t.integer "course",         limit: 8,          default: 0,               null: false
    t.string  "name",                              default: "Wiki",          null: false
    t.integer "timemodified",   limit: 8,          default: 0,               null: false
    t.text    "intro",          limit: 2147483647
    t.integer "introformat",    limit: 2,          default: 0,               null: false
    t.integer "timecreated",    limit: 8,          default: 0,               null: false
    t.string  "firstpagetitle",                    default: "First Page",    null: false
    t.string  "wikimode",       limit: 20,         default: "collaborative", null: false
    t.string  "defaultformat",  limit: 20,         default: "creole",        null: false
    t.boolean "forceformat",                       default: true,            null: false
    t.integer "editbegin",      limit: 8,          default: 0,               null: false
    t.integer "editend",        limit: 8,          default: 0
  end

  add_index "mdl_wiki", ["course"], name: "mdl_wiki_cou_ix", using: :btree

  create_table "mdl_wiki_links", force: true do |t|
    t.integer "subwikiid",     limit: 8, default: 0, null: false
    t.integer "frompageid",    limit: 8, default: 0, null: false
    t.integer "topageid",      limit: 8, default: 0, null: false
    t.string  "tomissingpage"
  end

  add_index "mdl_wiki_links", ["frompageid"], name: "mdl_wikilink_fro_ix", using: :btree
  add_index "mdl_wiki_links", ["subwikiid"], name: "mdl_wikilink_sub_ix", using: :btree

  create_table "mdl_wiki_locks", force: true do |t|
    t.integer "pageid",      limit: 8, default: 0, null: false
    t.string  "sectionname"
    t.integer "userid",      limit: 8, default: 0, null: false
    t.integer "lockedat",    limit: 8, default: 0, null: false
  end

  create_table "mdl_wiki_pages", force: true do |t|
    t.integer "subwikiid",     limit: 8,          default: 0,       null: false
    t.string  "title",                            default: "title", null: false
    t.text    "cachedcontent", limit: 2147483647,                   null: false
    t.integer "timecreated",   limit: 8,          default: 0,       null: false
    t.integer "timemodified",  limit: 8,          default: 0,       null: false
    t.integer "timerendered",  limit: 8,          default: 0,       null: false
    t.integer "userid",        limit: 8,          default: 0,       null: false
    t.integer "pageviews",     limit: 8,          default: 0,       null: false
    t.boolean "readonly",                         default: false,   null: false
  end

  add_index "mdl_wiki_pages", ["subwikiid", "title", "userid"], name: "mdl_wikipage_subtituse_uix", unique: true, using: :btree
  add_index "mdl_wiki_pages", ["subwikiid"], name: "mdl_wikipage_sub_ix", using: :btree

  create_table "mdl_wiki_subwikis", force: true do |t|
    t.integer "wikiid",  limit: 8, default: 0, null: false
    t.integer "groupid", limit: 8, default: 0, null: false
    t.integer "userid",  limit: 8, default: 0, null: false
  end

  add_index "mdl_wiki_subwikis", ["wikiid", "groupid", "userid"], name: "mdl_wikisubw_wikgrouse_uix", unique: true, using: :btree
  add_index "mdl_wiki_subwikis", ["wikiid"], name: "mdl_wikisubw_wik_ix", using: :btree

  create_table "mdl_wiki_synonyms", force: true do |t|
    t.integer "subwikiid",   limit: 8, default: 0,             null: false
    t.integer "pageid",      limit: 8, default: 0,             null: false
    t.string  "pagesynonym",           default: "Pagesynonym", null: false
  end

  add_index "mdl_wiki_synonyms", ["pageid", "pagesynonym"], name: "mdl_wikisyno_pagpag_uix", unique: true, using: :btree

  create_table "mdl_wiki_versions", force: true do |t|
    t.integer "pageid",        limit: 8,          default: 0,        null: false
    t.text    "content",       limit: 2147483647,                    null: false
    t.string  "contentformat", limit: 20,         default: "creole", null: false
    t.integer "version",       limit: 3,          default: 0,        null: false
    t.integer "timecreated",   limit: 8,          default: 0,        null: false
    t.integer "userid",        limit: 8,          default: 0,        null: false
  end

  add_index "mdl_wiki_versions", ["pageid"], name: "mdl_wikivers_pag_ix", using: :btree

  create_table "mdl_workshop", force: true do |t|
    t.integer "course",                  limit: 8,                                                    null: false
    t.string  "name",                                                                default: "",     null: false
    t.text    "intro",                   limit: 2147483647
    t.integer "introformat",             limit: 2,                                   default: 0,      null: false
    t.text    "instructauthors",         limit: 2147483647
    t.integer "instructauthorsformat",   limit: 2,                                   default: 0,      null: false
    t.text    "instructreviewers",       limit: 2147483647
    t.integer "instructreviewersformat", limit: 2,                                   default: 0,      null: false
    t.integer "timemodified",            limit: 8,                                                    null: false
    t.integer "phase",                   limit: 2,                                   default: 0
    t.integer "useexamples",             limit: 1,                                   default: 0
    t.integer "usepeerassessment",       limit: 1,                                   default: 0
    t.integer "useselfassessment",       limit: 1,                                   default: 0
    t.decimal "grade",                                      precision: 10, scale: 5, default: 80.0
    t.decimal "gradinggrade",                               precision: 10, scale: 5, default: 20.0
    t.string  "strategy",                limit: 30,                                  default: "",     null: false
    t.string  "evaluation",              limit: 30,                                  default: "",     null: false
    t.integer "gradedecimals",           limit: 2,                                   default: 0
    t.integer "nattachments",            limit: 2,                                   default: 0
    t.integer "latesubmissions",         limit: 1,                                   default: 0
    t.integer "maxbytes",                limit: 8,                                   default: 100000
    t.integer "examplesmode",            limit: 2,                                   default: 0
    t.integer "submissionstart",         limit: 8,                                   default: 0
    t.integer "submissionend",           limit: 8,                                   default: 0
    t.integer "assessmentstart",         limit: 8,                                   default: 0
    t.integer "assessmentend",           limit: 8,                                   default: 0
    t.integer "phaseswitchassessment",   limit: 1,                                   default: 0,      null: false
    t.text    "conclusion",              limit: 2147483647
    t.integer "conclusionformat",        limit: 2,                                   default: 1,      null: false
    t.integer "overallfeedbackmode",     limit: 2,                                   default: 1
    t.integer "overallfeedbackfiles",    limit: 2,                                   default: 0
    t.integer "overallfeedbackmaxbytes", limit: 8,                                   default: 100000
  end

  add_index "mdl_workshop", ["course"], name: "mdl_work_cou_ix", using: :btree

  create_table "mdl_workshop_aggregations", force: true do |t|
    t.integer "workshopid",   limit: 8,                          null: false
    t.integer "userid",       limit: 8,                          null: false
    t.decimal "gradinggrade",           precision: 10, scale: 5
    t.integer "timegraded",   limit: 8
  end

  add_index "mdl_workshop_aggregations", ["userid"], name: "mdl_workaggr_use_ix", using: :btree
  add_index "mdl_workshop_aggregations", ["workshopid", "userid"], name: "mdl_workaggr_woruse_uix", unique: true, using: :btree
  add_index "mdl_workshop_aggregations", ["workshopid"], name: "mdl_workaggr_wor_ix", using: :btree

  create_table "mdl_workshop_assessments", force: true do |t|
    t.integer "submissionid",             limit: 8,                                               null: false
    t.integer "reviewerid",               limit: 8,                                               null: false
    t.integer "weight",                   limit: 8,                                   default: 1, null: false
    t.integer "timecreated",              limit: 8,                                   default: 0
    t.integer "timemodified",             limit: 8,                                   default: 0
    t.decimal "grade",                                       precision: 10, scale: 5
    t.decimal "gradinggrade",                                precision: 10, scale: 5
    t.decimal "gradinggradeover",                            precision: 10, scale: 5
    t.integer "gradinggradeoverby",       limit: 8
    t.text    "feedbackauthor",           limit: 2147483647
    t.integer "feedbackauthorformat",     limit: 2,                                   default: 0
    t.integer "feedbackauthorattachment", limit: 2,                                   default: 0
    t.text    "feedbackreviewer",         limit: 2147483647
    t.integer "feedbackreviewerformat",   limit: 2,                                   default: 0
  end

  add_index "mdl_workshop_assessments", ["gradinggradeoverby"], name: "mdl_workasse_gra_ix", using: :btree
  add_index "mdl_workshop_assessments", ["reviewerid"], name: "mdl_workasse_rev_ix", using: :btree
  add_index "mdl_workshop_assessments", ["submissionid"], name: "mdl_workasse_sub_ix", using: :btree

  create_table "mdl_workshop_assessments_old", force: true do |t|
    t.integer "workshopid",     limit: 8,          default: 0,   null: false
    t.integer "submissionid",   limit: 8,          default: 0,   null: false
    t.integer "userid",         limit: 8,          default: 0,   null: false
    t.integer "timecreated",    limit: 8,          default: 0,   null: false
    t.integer "timegraded",     limit: 8,          default: 0,   null: false
    t.integer "timeagreed",     limit: 8,          default: 0,   null: false
    t.float   "grade",                             default: 0.0, null: false
    t.integer "gradinggrade",   limit: 2,          default: 0,   null: false
    t.integer "teachergraded",  limit: 2,          default: 0,   null: false
    t.integer "mailed",         limit: 2,          default: 0,   null: false
    t.integer "resubmission",   limit: 2,          default: 0,   null: false
    t.integer "donotuse",       limit: 2,          default: 0,   null: false
    t.text    "generalcomment", limit: 2147483647
    t.text    "teachercomment", limit: 2147483647
    t.string  "newplugin",      limit: 28
    t.integer "newid",          limit: 8
  end

  add_index "mdl_workshop_assessments_old", ["mailed"], name: "mdl_workasse_mai_ix", using: :btree
  add_index "mdl_workshop_assessments_old", ["submissionid"], name: "mdl_workasse_sub_ix", using: :btree
  add_index "mdl_workshop_assessments_old", ["userid"], name: "mdl_workasse_use_ix", using: :btree
  add_index "mdl_workshop_assessments_old", ["workshopid"], name: "mdl_workasse_wor_ix", using: :btree

  create_table "mdl_workshop_comments_old", force: true do |t|
    t.integer "workshopid",   limit: 8,          default: 0, null: false
    t.integer "assessmentid", limit: 8,          default: 0, null: false
    t.integer "userid",       limit: 8,          default: 0, null: false
    t.integer "timecreated",  limit: 8,          default: 0, null: false
    t.integer "mailed",       limit: 1,          default: 0, null: false
    t.text    "comments",     limit: 2147483647,             null: false
    t.string  "newplugin",    limit: 28
    t.integer "newid",        limit: 8
  end

  add_index "mdl_workshop_comments_old", ["assessmentid"], name: "mdl_workcomm_ass_ix", using: :btree
  add_index "mdl_workshop_comments_old", ["mailed"], name: "mdl_workcomm_mai_ix", using: :btree
  add_index "mdl_workshop_comments_old", ["userid"], name: "mdl_workcomm_use_ix", using: :btree
  add_index "mdl_workshop_comments_old", ["workshopid"], name: "mdl_workcomm_wor_ix", using: :btree

  create_table "mdl_workshop_elements_old", force: true do |t|
    t.integer "workshopid",       limit: 8,          default: 0,   null: false
    t.integer "elementno",        limit: 2,          default: 0,   null: false
    t.text    "description",      limit: 2147483647,               null: false
    t.integer "scale",            limit: 2,          default: 0,   null: false
    t.integer "maxscore",         limit: 2,          default: 1,   null: false
    t.integer "weight",           limit: 2,          default: 11,  null: false
    t.float   "stddev",                              default: 0.0, null: false
    t.integer "totalassessments", limit: 8,          default: 0,   null: false
    t.string  "newplugin",        limit: 28
    t.integer "newid",            limit: 8
  end

  add_index "mdl_workshop_elements_old", ["workshopid"], name: "mdl_workelem_wor_ix", using: :btree

  create_table "mdl_workshop_grades", force: true do |t|
    t.integer "assessmentid",      limit: 8,                                                null: false
    t.string  "strategy",          limit: 30,                                  default: "", null: false
    t.integer "dimensionid",       limit: 8,                                                null: false
    t.decimal "grade",                                precision: 10, scale: 5,              null: false
    t.text    "peercomment",       limit: 2147483647
    t.integer "peercommentformat", limit: 2,                                   default: 0
  end

  add_index "mdl_workshop_grades", ["assessmentid", "strategy", "dimensionid"], name: "mdl_workgrad_assstrdim_uix", unique: true, using: :btree
  add_index "mdl_workshop_grades", ["assessmentid"], name: "mdl_workgrad_ass_ix", using: :btree

  create_table "mdl_workshop_grades_old", force: true do |t|
    t.integer "workshopid",   limit: 8,          default: 0, null: false
    t.integer "assessmentid", limit: 8,          default: 0, null: false
    t.integer "elementno",    limit: 8,          default: 0, null: false
    t.text    "feedback",     limit: 2147483647,             null: false
    t.integer "grade",        limit: 2,          default: 0, null: false
    t.string  "newplugin",    limit: 28
    t.integer "newid",        limit: 8
  end

  add_index "mdl_workshop_grades_old", ["assessmentid"], name: "mdl_workgrad_ass_ix", using: :btree
  add_index "mdl_workshop_grades_old", ["workshopid"], name: "mdl_workgrad_wor_ix", using: :btree

  create_table "mdl_workshop_old", force: true do |t|
    t.integer "course",           limit: 8,          default: 0,      null: false
    t.string  "name",                                default: "",     null: false
    t.text    "description",      limit: 2147483647,                  null: false
    t.integer "wtype",            limit: 2,          default: 0,      null: false
    t.integer "nelements",        limit: 2,          default: 1,      null: false
    t.integer "nattachments",     limit: 2,          default: 0,      null: false
    t.integer "phase",            limit: 1,          default: 0,      null: false
    t.integer "format",           limit: 1,          default: 0,      null: false
    t.integer "gradingstrategy",  limit: 1,          default: 1,      null: false
    t.integer "resubmit",         limit: 1,          default: 0,      null: false
    t.integer "agreeassessments", limit: 1,          default: 0,      null: false
    t.integer "hidegrades",       limit: 1,          default: 0,      null: false
    t.integer "anonymous",        limit: 1,          default: 0,      null: false
    t.integer "includeself",      limit: 1,          default: 0,      null: false
    t.integer "maxbytes",         limit: 8,          default: 100000, null: false
    t.integer "submissionstart",  limit: 8,          default: 0,      null: false
    t.integer "assessmentstart",  limit: 8,          default: 0,      null: false
    t.integer "submissionend",    limit: 8,          default: 0,      null: false
    t.integer "assessmentend",    limit: 8,          default: 0,      null: false
    t.integer "releasegrades",    limit: 8,          default: 0,      null: false
    t.integer "grade",            limit: 2,          default: 0,      null: false
    t.integer "gradinggrade",     limit: 2,          default: 0,      null: false
    t.integer "ntassessments",    limit: 2,          default: 0,      null: false
    t.integer "assessmentcomps",  limit: 2,          default: 2,      null: false
    t.integer "nsassessments",    limit: 2,          default: 0,      null: false
    t.integer "overallocation",   limit: 2,          default: 0,      null: false
    t.integer "timemodified",     limit: 8,          default: 0,      null: false
    t.integer "teacherweight",    limit: 2,          default: 1,      null: false
    t.integer "showleaguetable",  limit: 2,          default: 0,      null: false
    t.integer "usepassword",      limit: 2,          default: 0,      null: false
    t.string  "password",         limit: 32,         default: "",     null: false
    t.string  "newplugin",        limit: 28
    t.integer "newid",            limit: 8
  end

  add_index "mdl_workshop_old", ["course"], name: "mdl_work_cou_ix", using: :btree

  create_table "mdl_workshop_rubrics_old", force: true do |t|
    t.integer "workshopid",  limit: 8,          default: 0, null: false
    t.integer "elementno",   limit: 8,          default: 0, null: false
    t.integer "rubricno",    limit: 2,          default: 0, null: false
    t.text    "description", limit: 2147483647,             null: false
    t.string  "newplugin",   limit: 28
    t.integer "newid",       limit: 8
  end

  add_index "mdl_workshop_rubrics_old", ["workshopid"], name: "mdl_workrubr_wor_ix", using: :btree

  create_table "mdl_workshop_stockcomments_old", force: true do |t|
    t.integer "workshopid", limit: 8,          default: 0, null: false
    t.integer "elementno",  limit: 8,          default: 0, null: false
    t.text    "comments",   limit: 2147483647,             null: false
    t.string  "newplugin",  limit: 28
    t.integer "newid",      limit: 8
  end

  add_index "mdl_workshop_stockcomments_old", ["workshopid"], name: "mdl_workstoc_wor_ix", using: :btree

  create_table "mdl_workshop_submissions", force: true do |t|
    t.integer "workshopid",           limit: 8,                                                null: false
    t.integer "example",              limit: 1,                                   default: 0
    t.integer "authorid",             limit: 8,                                                null: false
    t.integer "timecreated",          limit: 8,                                                null: false
    t.integer "timemodified",         limit: 8,                                                null: false
    t.string  "title",                                                            default: "", null: false
    t.text    "content",              limit: 2147483647
    t.integer "contentformat",        limit: 2,                                   default: 0,  null: false
    t.integer "contenttrust",         limit: 2,                                   default: 0,  null: false
    t.integer "attachment",           limit: 1,                                   default: 0
    t.decimal "grade",                                   precision: 10, scale: 5
    t.decimal "gradeover",                               precision: 10, scale: 5
    t.integer "gradeoverby",          limit: 8
    t.text    "feedbackauthor",       limit: 2147483647
    t.integer "feedbackauthorformat", limit: 2,                                   default: 0
    t.integer "timegraded",           limit: 8
    t.integer "published",            limit: 1,                                   default: 0
    t.integer "late",                 limit: 1,                                   default: 0,  null: false
  end

  add_index "mdl_workshop_submissions", ["authorid"], name: "mdl_worksubm_aut_ix", using: :btree
  add_index "mdl_workshop_submissions", ["gradeoverby"], name: "mdl_worksubm_gra_ix", using: :btree
  add_index "mdl_workshop_submissions", ["workshopid"], name: "mdl_worksubm_wor_ix", using: :btree

  create_table "mdl_workshop_submissions_old", force: true do |t|
    t.integer "workshopid",   limit: 8,          default: 0,  null: false
    t.integer "userid",       limit: 8,          default: 0,  null: false
    t.string  "title",        limit: 100,        default: "", null: false
    t.integer "timecreated",  limit: 8,          default: 0,  null: false
    t.integer "mailed",       limit: 1,          default: 0,  null: false
    t.text    "description",  limit: 2147483647,              null: false
    t.integer "gradinggrade", limit: 2,          default: 0,  null: false
    t.integer "finalgrade",   limit: 2,          default: 0,  null: false
    t.integer "late",         limit: 2,          default: 0,  null: false
    t.integer "nassessments", limit: 8,          default: 0,  null: false
    t.string  "newplugin",    limit: 28
    t.integer "newid",        limit: 8
  end

  add_index "mdl_workshop_submissions_old", ["mailed"], name: "mdl_worksubm_mai_ix", using: :btree
  add_index "mdl_workshop_submissions_old", ["userid"], name: "mdl_worksubm_use_ix", using: :btree
  add_index "mdl_workshop_submissions_old", ["workshopid"], name: "mdl_worksubm_wor_ix", using: :btree

  create_table "mdl_workshopallocation_scheduled", force: true do |t|
    t.integer "workshopid",    limit: 8,                      null: false
    t.integer "enabled",       limit: 1,          default: 0, null: false
    t.integer "submissionend", limit: 8,                      null: false
    t.integer "timeallocated", limit: 8
    t.text    "settings",      limit: 2147483647
    t.integer "resultstatus",  limit: 8
    t.string  "resultmessage", limit: 1333
    t.text    "resultlog",     limit: 2147483647
  end

  add_index "mdl_workshopallocation_scheduled", ["workshopid"], name: "mdl_worksche_wor_uix", unique: true, using: :btree

  create_table "mdl_workshopeval_best_settings", force: true do |t|
    t.integer "workshopid", limit: 8,             null: false
    t.integer "comparison", limit: 2, default: 5
  end

  add_index "mdl_workshopeval_best_settings", ["workshopid"], name: "mdl_workbestsett_wor_uix", unique: true, using: :btree

  create_table "mdl_workshopform_accumulative", force: true do |t|
    t.integer "workshopid",        limit: 8,                      null: false
    t.integer "sort",              limit: 8,          default: 0
    t.text    "description",       limit: 2147483647
    t.integer "descriptionformat", limit: 2,          default: 0
    t.integer "grade",             limit: 8,                      null: false
    t.integer "weight",            limit: 3,          default: 1
  end

  add_index "mdl_workshopform_accumulative", ["workshopid"], name: "mdl_workaccu_wor_ix", using: :btree

  create_table "mdl_workshopform_comments", force: true do |t|
    t.integer "workshopid",        limit: 8,                      null: false
    t.integer "sort",              limit: 8,          default: 0
    t.text    "description",       limit: 2147483647
    t.integer "descriptionformat", limit: 2,          default: 0
  end

  add_index "mdl_workshopform_comments", ["workshopid"], name: "mdl_workcomm_wor_ix", using: :btree

  create_table "mdl_workshopform_numerrors", force: true do |t|
    t.integer "workshopid",        limit: 8,                      null: false
    t.integer "sort",              limit: 8,          default: 0
    t.text    "description",       limit: 2147483647
    t.integer "descriptionformat", limit: 2,          default: 0
    t.integer "descriptiontrust",  limit: 8
    t.string  "grade0",            limit: 50
    t.string  "grade1",            limit: 50
    t.integer "weight",            limit: 3,          default: 1
  end

  add_index "mdl_workshopform_numerrors", ["workshopid"], name: "mdl_worknume_wor_ix", using: :btree

  create_table "mdl_workshopform_numerrors_map", force: true do |t|
    t.integer "workshopid", limit: 8,                          null: false
    t.integer "nonegative", limit: 8,                          null: false
    t.decimal "grade",                precision: 10, scale: 5, null: false
  end

  add_index "mdl_workshopform_numerrors_map", ["workshopid", "nonegative"], name: "mdl_worknumemap_wornon_uix", unique: true, using: :btree
  add_index "mdl_workshopform_numerrors_map", ["workshopid"], name: "mdl_worknumemap_wor_ix", using: :btree

  create_table "mdl_workshopform_rubric", force: true do |t|
    t.integer "workshopid",        limit: 8,                      null: false
    t.integer "sort",              limit: 8,          default: 0
    t.text    "description",       limit: 2147483647
    t.integer "descriptionformat", limit: 2,          default: 0
  end

  add_index "mdl_workshopform_rubric", ["workshopid"], name: "mdl_workrubr_wor_ix", using: :btree

  create_table "mdl_workshopform_rubric_config", force: true do |t|
    t.integer "workshopid", limit: 8,                   null: false
    t.string  "layout",     limit: 30, default: "list"
  end

  add_index "mdl_workshopform_rubric_config", ["workshopid"], name: "mdl_workrubrconf_wor_uix", unique: true, using: :btree

  create_table "mdl_workshopform_rubric_levels", force: true do |t|
    t.integer "dimensionid",      limit: 8,                                               null: false
    t.decimal "grade",                               precision: 10, scale: 5,             null: false
    t.text    "definition",       limit: 2147483647
    t.integer "definitionformat", limit: 2,                                   default: 0
  end

  add_index "mdl_workshopform_rubric_levels", ["dimensionid"], name: "mdl_workrubrleve_dim_ix", using: :btree

  create_table "user_reports", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "username",   limit: 45
    t.string   "password",   limit: 100
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "wp_commentmeta", primary_key: "meta_id", force: true do |t|
    t.integer "comment_id", limit: 8,          default: 0, null: false
    t.string  "meta_key"
    t.text    "meta_value", limit: 2147483647
  end

  add_index "wp_commentmeta", ["comment_id"], name: "comment_id", using: :btree
  add_index "wp_commentmeta", ["meta_key"], name: "meta_key", using: :btree

  create_table "wp_comments", primary_key: "comment_ID", force: true do |t|
    t.integer  "comment_post_ID",      limit: 8,   default: 0,   null: false
    t.text     "comment_author",       limit: 255,               null: false
    t.string   "comment_author_email", limit: 100, default: "",  null: false
    t.string   "comment_author_url",   limit: 200, default: "",  null: false
    t.string   "comment_author_IP",    limit: 100, default: "",  null: false
    t.datetime "comment_date",                                   null: false
    t.datetime "comment_date_gmt",                               null: false
    t.text     "comment_content",                                null: false
    t.integer  "comment_karma",                    default: 0,   null: false
    t.string   "comment_approved",     limit: 20,  default: "1", null: false
    t.string   "comment_agent",                    default: "",  null: false
    t.string   "comment_type",         limit: 20,  default: "",  null: false
    t.integer  "comment_parent",       limit: 8,   default: 0,   null: false
    t.integer  "user_id",              limit: 8,   default: 0,   null: false
  end

  add_index "wp_comments", ["comment_approved", "comment_date_gmt"], name: "comment_approved_date_gmt", using: :btree
  add_index "wp_comments", ["comment_date_gmt"], name: "comment_date_gmt", using: :btree
  add_index "wp_comments", ["comment_parent"], name: "comment_parent", using: :btree
  add_index "wp_comments", ["comment_post_ID"], name: "comment_post_ID", using: :btree

  create_table "wp_links", primary_key: "link_id", force: true do |t|
    t.string   "link_url",                          default: "",  null: false
    t.string   "link_name",                         default: "",  null: false
    t.string   "link_image",                        default: "",  null: false
    t.string   "link_target",      limit: 25,       default: "",  null: false
    t.string   "link_description",                  default: "",  null: false
    t.string   "link_visible",     limit: 20,       default: "Y", null: false
    t.integer  "link_owner",       limit: 8,        default: 1,   null: false
    t.integer  "link_rating",                       default: 0,   null: false
    t.datetime "link_updated",                                    null: false
    t.string   "link_rel",                          default: "",  null: false
    t.text     "link_notes",       limit: 16777215,               null: false
    t.string   "link_rss",                          default: "",  null: false
  end

  add_index "wp_links", ["link_visible"], name: "link_visible", using: :btree

  create_table "wp_options", primary_key: "option_id", force: true do |t|
    t.string "option_name",  limit: 64,         default: "",    null: false
    t.text   "option_value", limit: 2147483647,                 null: false
    t.string "autoload",     limit: 20,         default: "yes", null: false
  end

  add_index "wp_options", ["option_name"], name: "option_name", unique: true, using: :btree

  create_table "wp_postmeta", primary_key: "meta_id", force: true do |t|
    t.integer "post_id",    limit: 8,          default: 0, null: false
    t.string  "meta_key"
    t.text    "meta_value", limit: 2147483647
  end

  add_index "wp_postmeta", ["meta_key"], name: "meta_key", using: :btree
  add_index "wp_postmeta", ["post_id"], name: "post_id", using: :btree

  create_table "wp_posts", primary_key: "ID", force: true do |t|
    t.integer  "post_author",           limit: 8,          default: 0,         null: false
    t.datetime "post_date",                                                    null: false
    t.datetime "post_date_gmt",                                                null: false
    t.text     "post_content",          limit: 2147483647,                     null: false
    t.text     "post_title",                                                   null: false
    t.text     "post_excerpt",                                                 null: false
    t.string   "post_status",           limit: 20,         default: "publish", null: false
    t.string   "comment_status",        limit: 20,         default: "open",    null: false
    t.string   "ping_status",           limit: 20,         default: "open",    null: false
    t.string   "post_password",         limit: 20,         default: "",        null: false
    t.string   "post_name",             limit: 200,        default: "",        null: false
    t.text     "to_ping",                                                      null: false
    t.text     "pinged",                                                       null: false
    t.datetime "post_modified",                                                null: false
    t.datetime "post_modified_gmt",                                            null: false
    t.text     "post_content_filtered", limit: 2147483647,                     null: false
    t.integer  "post_parent",           limit: 8,          default: 0,         null: false
    t.string   "guid",                                     default: "",        null: false
    t.integer  "menu_order",                               default: 0,         null: false
    t.string   "post_type",             limit: 20,         default: "post",    null: false
    t.string   "post_mime_type",        limit: 100,        default: "",        null: false
    t.integer  "comment_count",         limit: 8,          default: 0,         null: false
  end

  add_index "wp_posts", ["post_author"], name: "post_author", using: :btree
  add_index "wp_posts", ["post_name"], name: "post_name", using: :btree
  add_index "wp_posts", ["post_parent"], name: "post_parent", using: :btree
  add_index "wp_posts", ["post_type", "post_status", "post_date", "ID"], name: "type_status_date", using: :btree

  create_table "wp_term_relationships", id: false, force: true do |t|
    t.integer "object_id",        limit: 8, default: 0, null: false
    t.integer "term_taxonomy_id", limit: 8, default: 0, null: false
    t.integer "term_order",                 default: 0, null: false
  end

  add_index "wp_term_relationships", ["term_taxonomy_id"], name: "term_taxonomy_id", using: :btree

  create_table "wp_term_taxonomy", primary_key: "term_taxonomy_id", force: true do |t|
    t.integer "term_id",     limit: 8,          default: 0,  null: false
    t.string  "taxonomy",    limit: 32,         default: "", null: false
    t.text    "description", limit: 2147483647,              null: false
    t.integer "parent",      limit: 8,          default: 0,  null: false
    t.integer "count",       limit: 8,          default: 0,  null: false
  end

  add_index "wp_term_taxonomy", ["taxonomy"], name: "taxonomy", using: :btree
  add_index "wp_term_taxonomy", ["term_id", "taxonomy"], name: "term_id_taxonomy", unique: true, using: :btree

  create_table "wp_terms", primary_key: "term_id", force: true do |t|
    t.string  "name",       limit: 200, default: "", null: false
    t.string  "slug",       limit: 200, default: "", null: false
    t.integer "term_group", limit: 8,   default: 0,  null: false
  end

  add_index "wp_terms", ["name"], name: "name", using: :btree
  add_index "wp_terms", ["slug"], name: "slug", unique: true, using: :btree

  create_table "wp_usermeta", primary_key: "umeta_id", force: true do |t|
    t.integer "user_id",    limit: 8,          default: 0, null: false
    t.string  "meta_key"
    t.text    "meta_value", limit: 2147483647
  end

  add_index "wp_usermeta", ["meta_key"], name: "meta_key", using: :btree
  add_index "wp_usermeta", ["user_id"], name: "user_id", using: :btree

  create_table "wp_users", primary_key: "ID", force: true do |t|
    t.string   "user_login",          limit: 60,  default: "", null: false
    t.string   "user_pass",           limit: 64,  default: "", null: false
    t.string   "user_nicename",       limit: 50,  default: "", null: false
    t.string   "user_email",          limit: 100, default: "", null: false
    t.string   "user_url",            limit: 100, default: "", null: false
    t.datetime "user_registered",                              null: false
    t.string   "user_activation_key", limit: 60,  default: "", null: false
    t.integer  "user_status",                     default: 0,  null: false
    t.string   "display_name",        limit: 250, default: "", null: false
  end

  add_index "wp_users", ["user_login"], name: "user_login_key", using: :btree
  add_index "wp_users", ["user_nicename"], name: "user_nicename", using: :btree

end
