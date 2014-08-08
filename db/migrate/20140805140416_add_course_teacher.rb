class AddCourseTeacher < ActiveRecord::Migration
  def up
  	add_column :courses, :teacher_user_id, :integer, after: :mode
  end

  def down
  	remove_column :courses, :teacher_user_id
  end
end
