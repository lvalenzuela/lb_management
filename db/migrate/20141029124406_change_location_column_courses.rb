class ChangeLocationColumnCourses < ActiveRecord::Migration
  def up
  	change_column :courses, :location, :integer, :default => 1
  	rename_column :courses, :location, :location_id
  end

  def down
  	change_column :courses, :location_id, :string
  	rename_column :courses, :location_id, :location
  end
end
