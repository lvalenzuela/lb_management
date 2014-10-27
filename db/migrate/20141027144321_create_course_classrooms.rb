class CreateCourseClassrooms < ActiveRecord::Migration
  def up
    create_table :course_classrooms do |t|
    	t.integer :course_id
    	t.integer :classroom_matching_id
    	t.date :course_start_date
    	t.date :course_end_date
      t.timestamps
    end
  end

  def down
  	drop_table :course_classrooms
  end
end
