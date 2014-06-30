class AddRoles < ActiveRecord::Migration
  def up
  	Role.create(:rolename => "Member", :description => "El usuario es miembro de una instancia, sin privilegios particulares sobre la misma")
  end

  def down
  	Role.where(:rolename => "Member").destroy_all
  end
end
