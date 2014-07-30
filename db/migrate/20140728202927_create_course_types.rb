class CreateCourseTypes < ActiveRecord::Migration
  def up
    create_table :course_types do |t|
    	t.string :typename
    	t.string :description
      	t.timestamps
    end
  end

  def down
  	drop_table :course_types
  end
end
