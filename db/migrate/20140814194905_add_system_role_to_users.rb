class AddSystemRoleToUsers < ActiveRecord::Migration
  def up
  	add_column :users, :system_role_id, :integer, after: :auth_token
  	remove_column :users, :permissionid
  end

  def down
  	remove_column :users, :system_role_id
  	add_column :users, :permissionid, :integer, after: :auth_token
  end
end
