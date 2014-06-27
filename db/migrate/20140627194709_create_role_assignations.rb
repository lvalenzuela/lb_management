class CreateRoleAssignations < ActiveRecord::Migration
  def up
    create_table :role_assignations do |t|
    	t.integer :contextid
    	t.integer :userid
    	t.integer :roleid
      	t.timestamps
    end
  end

  def down
  	drop_table :role_assignations
  end
end
