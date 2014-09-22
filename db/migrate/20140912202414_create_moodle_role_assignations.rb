class CreateMoodleRoleAssignations < ActiveRecord::Migration
  def up
    create_table :moodle_role_assignations, :id => false do |t|
    	t.integer :id
    	t.integer :userid
    	t.integer :courseid
    	t.integer :roleid
    	t.string :rolename
      	t.timestamps
    end
  end

  def down
  	drop_table :moodle_role_assignations
  end
end
