class AddClassroomToWeekdaySession < ActiveRecord::Migration
  def up
  	add_column :course_session_weekdays, :course_classroom_id, :integer, :after => :session_start_hour
  end

  def down
  	remove_column :course_session_weekdays, :course_classroom_id
  end
end
