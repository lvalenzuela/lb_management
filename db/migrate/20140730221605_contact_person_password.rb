class ContactPersonPassword < ActiveRecord::Migration
  def up
  	add_column :contact_people, :password, :string, after: :email
  	add_column :contact_people, :zoho_contact_person_id, :string, after: :id
  	add_column :contact_people, :zoho_enabled, :boolean, after: :is_primary_contact
    add_column :contact_people, :birthday, :date, after: :salutation
    add_column :contact_people, :rut, :string, after: :lastname
  	add_column :contacts, :zoho_contact_id, :string, after: :id
  	add_column :contacts, :zoho_enabled, :boolean, after: :notes
  end

  def down
  	remove_column :contact_people, :password
  	remove_column :contact_people, :zoho_contact_person_id
  	remove_column :contact_people, :zoho_enabled
    remove_column :contact_people, :birthday
    remove_column :contact_people, :rut
  	remove_column :contacts, :zoho_contact_id
  	remove_column :contacts, :zoho_enabled
  end
end
