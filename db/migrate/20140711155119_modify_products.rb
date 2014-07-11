class ModifyProducts < ActiveRecord::Migration
  def up
  	add_column :products, :location, :string
  	remove_column :products, :courseid
  end

  def down
  	add_column :products, :courseid, :integer
  	remove_column :products, :location
  end
end
