class CreateCourseClassrooms < ActiveRecord::Migration
  def up
    create_table :course_classrooms do |t|
    	t.string :name
    	t.integer :capacity
      t.timestamps
    end
  end

  def down
  	drop_table :course_classrooms
  end
end
