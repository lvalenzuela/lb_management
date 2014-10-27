class AddDurationToClassroomAvailabilites < ActiveRecord::Migration
  def up
  	add_column :classroom_availabilities, :duration, :integer, :after => :start_hour
  	add_column :classroom_availabilities, :prime, :integer, :after => :duration
  end

  def down
  	remove_column :classroom_availabilities, :duration
  	remove_column :classroom_availabilities, :prime
  end
end
