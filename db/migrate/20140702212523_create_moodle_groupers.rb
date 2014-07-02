class CreateMoodleGroupers < ActiveRecord::Migration
  def up
    create_table :moodle_groupers do |t|
    	t.integer :m_coursegroupid
    	t.integer :m_courseid
      	t.timestamps
    end
  end

  def down
  	drop_table :moodle_groupers
  end
end
