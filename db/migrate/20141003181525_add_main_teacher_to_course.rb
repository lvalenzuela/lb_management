class AddMainTeacherToCourse < ActiveRecord::Migration
  def up
  	add_column :courses, :main_teacher_id, :integer, :after => :mode
  end

  def down
  	remove_column :courses, :main_teacher_id
  end
end
