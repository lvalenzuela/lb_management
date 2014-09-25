class DropMoodleRoleAssignationsTable < ActiveRecord::Migration
  def up
  	drop_table :moodle_role_assignations
  end

  def down
  	create_table :moodle_role_assignations do |t|
  		t.timestamps
  	end
  end
end
