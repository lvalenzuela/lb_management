class AddSenceFlagToMoodleCourses < ActiveRecord::Migration
  def up
  	add_column :moodle_courses, :sence, :boolean, :after => :end_date
  end

  def down
  	remove_column :moodle_courses, :sence
  end
end
