class AddTypeidCourses < ActiveRecord::Migration
  def up
  	add_column :courses, :course_type_id, :integer
  end

  def down
  	remove_column :courses, :course_type_id
  end
end
