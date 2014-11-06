class DropAlarmDataTable < ActiveRecord::Migration
  def up
  	drop_table :course_alarm_data
  end

  def down
  	create_table :course_alarm_data do |t|
  		t.timestamps
  	end
  end
end
