class AddAuthTokenToContactPerson < ActiveRecord::Migration
  def up
  	add_column :contact_people, :auth_token, :string, after: :contact_id
  end

  def down
  	remove_column :contact_people, :auth_token
  end
end
