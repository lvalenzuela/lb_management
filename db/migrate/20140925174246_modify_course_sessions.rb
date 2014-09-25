class ModifyCourseSessions < ActiveRecord::Migration
  def up
  	add_column :course_sessions, :session_number, :integer, after: :enddatetime
  	rename_column :course_sessions, :courseid, :commerce_course_id
  	add_column :course_sessions, :moodle_course_id, :integer, after: :commerce_course_id
  end

  def down
  	remove_column :course_sessions, :session_number
  	rename_column :course_sessions, :commerce_course_id, :courseid
  	remove_column :course_sessions, :moodle_course_id
  end
end
