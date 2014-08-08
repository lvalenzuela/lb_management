class AddAuthTokenToUser < ActiveRecord::Migration
  def up
  	add_column :users, :auth_token, :string, after: :username
  end

  def down
  	remove_column :users, :auth_token
  end
end
