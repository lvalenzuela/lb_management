class ChangeLocationToLocationIdOnClassroom < ActiveRecord::Migration
  def up
  	change_column :classrooms, :location, :integer, :default => nil
  	rename_column :classrooms, :location, :location_id
  end

  def down
  	rename_column :classrooms, :location_id, :location
  	change_column :classrooms, :location, :string, :default => nil
  end
end
