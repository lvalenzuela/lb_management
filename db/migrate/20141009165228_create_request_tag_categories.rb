class CreateRequestTagCategories < ActiveRecord::Migration
  def up
    create_table :request_tag_categories do |t|
    	t.string :name
    	t.string :description
      	t.timestamps
    end
    #Primeras categorias de requerimientos
    RequestTagCategory.create(:name => "Default", :description => "Requerimiento regular para miembros del area.")
    RequestTagCategory.create(:name => "Inicialización Curso", :description => "Tareas asignadas al inicializar un curso desde summit y traspasarlo finalmente a moodle.")
  end

  def down
  	drop_table :request_tag_categories
  end
end
