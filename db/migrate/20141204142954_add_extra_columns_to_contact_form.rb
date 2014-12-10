class AddExtraColumnsToContactForm < ActiveRecord::Migration
  def up
  	add_column :web_contact_forms, :free_service, :string, :after => :email
  	add_column :web_contact_forms, :paid_service, :string, :after => :free_service
  end

  def down
  	remove_column :web_contact_forms, :free_service
  	remove_column :web_contact_forms, :paid_service
  end
end
