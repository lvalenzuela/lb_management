class DefaultContactTypes < ActiveRecord::Migration
  def up
  	ContactType.create(:typename => "Longbourn", :description => "Longbourn Institute registrado como cliente para facilitar la generacion de Cotizaciones.")
  	ContactType.create(:typename => "Persona", :description => "Persona natural")
  	ContactType.create(:typename => "Empresa", :description => "Contacto que representa a una empresa.")
  end

  def down
  	ContactType.where(:typename => "Longbourn").destroy_all
  	ContactType.where(:typename => "Persona").destroy_all
  	ContactType.where(:typename => "Empresa").destroy_all
  end
end
