class AddLoadStatusToUsers < ActiveRecord::Migration
  def up
  	add_column :users, :current_load, :integer, :after => :avatar_updated_at, :default => 0
  	add_column :users, :total_load, :integer, :after => :current_load, :default => 0
  end

  def down
  	remove_column :users, :current_load
  	remove_column :users, :total_load
  end
end
