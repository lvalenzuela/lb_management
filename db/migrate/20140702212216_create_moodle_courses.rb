class CreateMoodleCourses < ActiveRecord::Migration
  def up
    create_table :moodle_courses do |t|
    	t.integer :moodleid
    	t.string :coursename
      	t.timestamps
    end
  end

  def down
  	drop_table :moodle_courses
  end
end
