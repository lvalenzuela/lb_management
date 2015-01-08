class AddLateContentToCourseCurrentAlarms < ActiveRecord::Migration
  def up
  	add_column :course_current_alarms, :courses_offset_content, :integer, :after => :courses_late_sessions
  end

  def down
  	remove_column :course_current_alarms, :courses_offset_content
  end
end
