class ChangeWeekdaySessionsHourColumn < ActiveRecord::Migration
  def up
  	change_column :course_session_weekdays, :session_start_hour, :string
  end

  def down
  	change_column :course_session_weekdays, :session_start_hour, :integer
  end
end
