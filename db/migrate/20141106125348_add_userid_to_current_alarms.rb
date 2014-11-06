class AddUseridToCurrentAlarms < ActiveRecord::Migration
  def up
  	add_column :course_current_alarms, :userid, :integer, :after => :id
  end

  def down
  	remove_column :course_current_alarms, :userid
  end
end
