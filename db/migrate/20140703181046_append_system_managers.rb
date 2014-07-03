class AppendSystemManagers < ActiveRecord::Migration
  def up
    RoleAssignation.create(:contextid => 1, :userid => 58, :roleid => 2)
    RoleAssignation.create(:contextid => 1, :userid => 138, :roleid => 2) 
  end

  def down
  	RoleAssignation.where(:contextid => 1, :userid => 58).destroy_all
  	RoleAssignation.where(:contextid => 1, :userid => 138).destroy_all
  end
end
