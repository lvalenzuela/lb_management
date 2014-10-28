class AddMeanGradeAndMeanAttendanceToAlarmData < ActiveRecord::Migration
  def up
  	add_column :course_alarm_data, :mean_attendance, :decimal, :precision => 5, :scale => 2, :after => :late_sessions
  end

  def down
  	remove_column :course_alarm_data, :mean_attendance
  end
end
