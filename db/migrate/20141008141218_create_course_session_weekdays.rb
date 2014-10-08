class CreateCourseSessionWeekdays < ActiveRecord::Migration
  def up
    create_table :course_session_weekdays do |t|
    	t.integer :course_id
    	t.integer :day_number
    	t.integer :session_start_hour
      	t.timestamps
    end
  end

  def down
  	drop_table :course_session_weekdays
  end
end
