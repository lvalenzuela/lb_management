class CreateMoodleGroupAssginations < ActiveRecord::Migration
  def up
    create_table :moodle_group_assignations do |t|
    	t.integer :groupid
    	t.integer :m_courseid
      	t.timestamps
    end
  end

  def down
  	drop_table :moodle_group_assignations
  end
end
