class CreateSenceAttendances < ActiveRecord::Migration
  def up
    create_table :sence_attendances do |t|
    	t.string :codigo_sence
    	t.string :sence_idnumber
    	t.string :institution
    	t.string :user_name
    	t.string :user_rut
      t.integer :course_total_hours
    	t.date :session_date
    	t.time :session_start_time
    	t.time :session_end_time
    	t.time :block_time
    	t.time :user_attendance_time
      	t.timestamps
    end
  end
  
  def down
  	drop_table :sence_attendances
  end
end
