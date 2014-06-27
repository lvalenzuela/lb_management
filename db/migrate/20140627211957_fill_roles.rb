class FillRoles < ActiveRecord::Migration
  def up
  	Role.create(:rolename => "Admin", :description => "Administrador")
  	Role.create(:rolename => "Manager", :description => "Usuario con privilegios")
  	RoleAssignation.create(:contextid => 1, :userid => 182, :roleid => 1)
    RoleAssignation.create(:contextid => 1, :userid => 181, :roleid => 2)
    RoleAssignation.create(:contextid => 1, :userid => 2, :roleid => 2)
  end

  def down
  	Role.where(:rolename => "Admin").destroy_all
  	Role.where(:rolename => "Manager").destroy_all
  	RoleAssignation.where(:contextid => 1, :roleid => [1,2]).destroy_all
  end
end
