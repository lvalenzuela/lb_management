class CreateUserDisponibilities < ActiveRecord::Migration
  def up
    create_table :user_disponibilities do |t|
    	t.integer :user_id
    	t.integer :day_number
    	t.time :start_time
    	t.time :end_time
    	t.date :start_date
    	t.date :end_date
      	t.timestamps
    end
  end

  def down
  	drop_table :user_disponibilities
  end
end
