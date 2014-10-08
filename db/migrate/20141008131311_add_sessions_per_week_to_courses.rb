class AddSessionsPerWeekToCourses < ActiveRecord::Migration
  def up
  	add_column :courses, :sessions_per_week, :integer, :after => :course_level_id
  end

  def down
  	remove_column :course, :sessions_per_week
  end
end
