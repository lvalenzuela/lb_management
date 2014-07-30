class ContactPersonPassword < ActiveRecord::Migration
  def up
  	add_column :contact_people, :password, :string, after: :email
  end

  def down
  	remove_column :contact_people, :password
  end
end
