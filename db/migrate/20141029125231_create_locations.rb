class CreateLocations < ActiveRecord::Migration
  def up
    create_table :locations do |t|
    	t.string :name
    	t.string :address
      	t.timestamps
    end
    #se crean inmediatamente ubicaciones
    Location.create(:name => "Sede Coronel Pereira", :address => "Coronel Pereira 77, Piso 11, Las Condes")
    Location.create(:name => "Oficinas del Cliente", :address => "No Especificado")
  end

  def down 
  	drop_table :locations
  end
end
