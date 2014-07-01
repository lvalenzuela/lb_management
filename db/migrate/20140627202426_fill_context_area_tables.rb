class FillContextAreaTables < ActiveRecord::Migration
  def up
    ContextDescription.create(:description => "Sistema")
  	ContextDescription.create(:description => "Gestión")
    ContextDescription.create(:description => "Docente")
    ContextDescription.create(:description => "Comercial")
    #El contexto con ID = 1 e instancia 0 corresponde al sistema 
    Context.create(:descriptionid => 1, :instanceid => 0)
    Role.create(:rolename => "Admin", :description => "Administrador del sistema")
    Role.create(:rolename => "Manager", :description => "Administrador local de instancias del sistema")
    #Se asigna al administrador del sistema
    RoleAssignation.create(:contextid => 1, :userid => 182, :roleid => 1)
    Area.create(:areaname => "Comercial", :description => "Área Comercial")
  	Area.create(:areaname => "Docente", :description => "Área Docente")
  	Area.create(:areaname => "Gerencia", :description => "Área de Gerencia")
  	Area.create(:areaname => "Sistemas y Procesos", :description => "Área de Sistemas y Procesos")
  end

  def down
  	Area.connection.execute("truncate table areas")
  	ContextDescription.connection.execute("truncate table context_descriptions")
  	Context.connection.execute("truncate table contexts")
    Role.connection.execute("truncate table roles")
    RoleAssignation.connection.execute("truncate table role_assignations")
  end
end
