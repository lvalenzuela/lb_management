class AddPagenumToCourseAttendance < ActiveRecord::Migration
  def up
  	add_column :course_attendance_reports, :last_visited_page, :integer, :after => :current_taken_sessions
  end

  def down
  	remove_column :course_attendance_reports, :last_visited_page
  end
end
