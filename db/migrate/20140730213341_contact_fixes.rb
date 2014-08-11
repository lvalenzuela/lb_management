class ContactFixes < ActiveRecord::Migration
  def up
  	remove_column :contacts, :lastname
  	rename_column :contacts, :fistname, :contact_name
  	add_column :contacts, :company_name, :string, after: :contact_name
  end

  def down
  	add_column :contacts, :lastname, :string
  	rename_column :contacts, :contact_name, :fistname
  	remove_column :contacts, :company_name
  end
end
