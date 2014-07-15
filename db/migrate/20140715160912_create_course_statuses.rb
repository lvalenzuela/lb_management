class CreateCourseStatuses < ActiveRecord::Migration
  def up
    create_table :course_statuses do |t|
    	t.string :statusname
    	t.string :description
      	t.timestamps
    end
  end

  def down
  	drop_table :course_statuses
  end
end
