class FillContextAreaTables < ActiveRecord::Migration
  def up
    ContextDescription.create(:description => "Sistema")
  	ContextDescription.create(:description => "Gestión")
    #El contexto con ID = 1 e instancia 0 corresponde al sistema 
    Context.create(:descriptionid => 1, :instanceid => 0)
    
    Area.create(:areaname => "Comercial", :description => "Área Comercial")
  	Area.create(:areaname => "Docente", :description => "Área Docente")
  	Area.create(:areaname => "Gerencia", :description => "Área de Gerencia")
  	Area.create(:areaname => "Sistemas y Procesos", :description => "Área de Sistemas y Procesos")
  end

  def down
  	Area.connection.execute("truncate table areas")
  	ContextDescription.connection.execute("truncate table context_descriptions")
  	Context.connection.execute("truncate table contexts")
  end
end
