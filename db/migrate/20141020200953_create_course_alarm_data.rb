class CreateCourseAlarmData < ActiveRecord::Migration
  def up
    create_table :course_alarm_data do |t|
    	t.integer :courseid
    	t.integer :late_sessions
    	t.decimal :failing_attendance, :precision => 5, :scale => 2
    	t.decimal :failing_grades, :precision => 5, :scale => 2
    	t.decimal :course_grade, :precision => 5, :scale => 2
      	t.timestamps
    end
  end

  def down
  	drop_table :course_alarm_data
  end
end
