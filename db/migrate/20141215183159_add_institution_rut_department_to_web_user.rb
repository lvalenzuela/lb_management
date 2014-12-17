class AddInstitutionRutDepartmentToWebUser < ActiveRecord::Migration
  def up
  	add_column :web_users, :rut, :string, :after => :lastname
  	add_column :web_users, :institution, :string, :after => :mobile
  	add_column :web_users, :department, :string, :after => :institution
  end

  def down
  	remove_column :web_users, :rut
  	remove_column :web_users, :institution
  	remove_column :web_users, :department
  end
end
