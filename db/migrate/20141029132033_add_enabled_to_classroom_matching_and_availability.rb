class AddEnabledToClassroomMatchingAndAvailability < ActiveRecord::Migration
  def up
  	add_column :classroom_availabilities, :enabled, :boolean, :after => :prime, :default => true
  	add_column :classroom_matchings, :enabled, :boolean, :after => :matching_array, :default => true
  end

  def down
  	remove_column :classroom_availabilities, :enabled
  	remove_column :classroom_matchings, :enabled
  end
end
