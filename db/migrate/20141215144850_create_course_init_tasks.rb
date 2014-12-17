class CreateCourseInitTasks < ActiveRecord::Migration
  def up
    create_table :course_init_tasks do |t|
    	t.integer :course_id
    	t.integer :request_id
      t.timestamps
    end
  end

  def down
  	drop_table :course_init_tasks
  end
end
