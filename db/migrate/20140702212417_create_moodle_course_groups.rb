class CreateMoodleCourseGroups < ActiveRecord::Migration
  def up
    create_table :moodle_course_groups do |t|
    	t.string :groupname
      t.timestamps
    end
  end

  def down 
  	drop_table :moodle_course_groups
  end
end
