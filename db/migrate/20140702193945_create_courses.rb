class CreateCourses < ActiveRecord::Migration
  def up
    create_table :courses do |t|
    	t.string :coursename
    	t.string :bookname
    	t.string :description
    	t.integer :max_students
    	t.integer :mode
    	t.timestamps
    end
  end

  def down
  	drop_table :courses
  end
end
