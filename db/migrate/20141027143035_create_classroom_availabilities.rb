class CreateClassroomAvailabilities < ActiveRecord::Migration
  def up
    create_table :classroom_availabilities do |t|
    	t.integer :classroom_id
    	t.integer :weekday
    	t.time :start_hour
      t.timestamps
    end
  end

  def down
  	drop_table :classroom_availabilities
  end
end
