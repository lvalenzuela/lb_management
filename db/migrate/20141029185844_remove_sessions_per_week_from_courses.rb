class RemoveSessionsPerWeekFromCourses < ActiveRecord::Migration
  def up
  	remove_column :courses, :sessions_per_week
  end

  def down
  	add_column :courses, :sessions_per_week, :integer, :after => :course_level_id
  end
end
