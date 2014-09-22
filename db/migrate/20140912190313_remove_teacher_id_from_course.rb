class RemoveTeacherIdFromCourse < ActiveRecord::Migration
  def up
  	remove_column :courses, :teacher_user_id
  end

  def down
  	add_column :courses, :teacher_user_id, :integer, after: :mode
  end
end
