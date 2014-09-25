class CreateMoodleCourseVs < ActiveRecord::Migration
  def up
  	remove_column :moodle_courses, :coursename
  	remove_column :moodle_courses, :start_date
  end

  def down
  	add_column :moodle_courses, :coursename, :string
  	add_column :moodle_courses, :start_date, :date
  end
end
