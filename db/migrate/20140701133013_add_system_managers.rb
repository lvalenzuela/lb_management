class AddSystemManagers < ActiveRecord::Migration
  def up
    RoleAssignation.create(:contextid => 1, :userid => 2, :roleid => 2)
    RoleAssignation.create(:contextid => 1, :userid => 181, :roleid => 2) 
  end

  def down
  	RoleAssignation.where(:contextid => 1, :userid => 2).destroy_all
  	RoleAssignation.where(:contextid => 1, :userid => 181).destroy_all
  end
end
