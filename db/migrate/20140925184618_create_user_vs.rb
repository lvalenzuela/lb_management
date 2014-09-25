class CreateUserVs < ActiveRecord::Migration
  def up
  	remove_column :users, :firstname
  	remove_column :users, :lastname
  	remove_column :users, :username
  	remove_column :users, :password
  	remove_column :users, :institution
  	remove_column :users, :department
  	remove_column :users, :email
  end

  def down
  	add_column :users, :firstname, :string
  	add_column :users, :lastname, :string
  	add_column :users, :username, :string
  	add_column :users, :password, :string
  	add_column :users, :institution, :string
  	add_column :users, :department, :string
  	add_column :users, :email, :string
  end
end
