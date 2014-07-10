class ClientColumns < ActiveRecord::Migration
  def up
  	change_column :contacts, :phone, :string
  	change_column :contacts, :rut, :string
  end

  def down
  	change_column :contacts, :phone, :integer
  	change_column :contacts, :rut, :integer
  end
end
