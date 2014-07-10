class AddAddressToContact < ActiveRecord::Migration
  def up
  	add_column :contacts, :address, :string
  end

  def down
  	remove_column :contacts, :address
  end
end
