class CreateCalendarHolydays < ActiveRecord::Migration
  def up
    create_table :calendar_holydays do |t|
    	t.date :date
    	t.integer :type
      	t.timestamps
    end
  end

  def down
  	drop_table :calendar_holydays
  end
end
