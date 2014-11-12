class CreateSenceAttendanceReports < ActiveRecord::Migration
  def up
    create_table :sence_attendance_reports do |t|
    	t.string :sence_idnumber
    	t.integer :course_id
    	t.string :user_idnumber
    	t.integer :p_sessions
    	t.integer :current_sessions
      t.integer :current_course_seconds
      t.integer :current_user_seconds
      t.timestamps
    end
  end

  def down
  	drop_table :sence_attendance_reports
  end
end
