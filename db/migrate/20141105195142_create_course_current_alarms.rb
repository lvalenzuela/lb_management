class CreateCourseCurrentAlarms < ActiveRecord::Migration
  def up
    create_table :course_current_alarms do |t|
    	t.integer :courses_failing_grades
    	t.integer :courses_failing_attendance
    	t.integer :courses_late_sessions
    	t.integer :teachers_low_performance
      	t.timestamps
    end
  end

  def down
  	drop_table :course_current_alarms
  end
end
