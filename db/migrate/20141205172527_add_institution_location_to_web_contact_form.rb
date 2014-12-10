class AddInstitutionLocationToWebContactForm < ActiveRecord::Migration
  def up
  	add_column :web_contact_forms, :location, :string, :after => :phone
  	add_column :web_contact_forms, :institution, :string, :after => :location
  end

  def down
  	remove_column :web_contact_forms, :location
  	remove_column :web_contact_forms, :institution
  end
end
