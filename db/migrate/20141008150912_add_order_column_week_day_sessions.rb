class AddOrderColumnWeekDaySessions < ActiveRecord::Migration
  def up
  	add_column :course_session_weekdays, :order, :integer, :after => :course_id
  end

  def down
  	remove_column :course_session_weekdays, :order
  end
end
