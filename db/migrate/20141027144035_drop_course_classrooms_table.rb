class DropCourseClassroomsTable < ActiveRecord::Migration
  def up
  	drop_table :course_classrooms
  end

  def down
  	create_table :course_classrooms do |t|
  		t.timestamps
  	end
  end
end
