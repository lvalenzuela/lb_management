class CreateMoodleGroups < ActiveRecord::Migration
  def up
    create_table :moodle_groups do |t|
    	t.string :groupname
      t.timestamps
    end
    drop_table :moodle_course_groups
    drop_table :moodle_groupers
  end

  def down 
  	drop_table :moodle_groups
  end
end
