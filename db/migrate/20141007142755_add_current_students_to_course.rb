class AddCurrentStudentsToCourse < ActiveRecord::Migration
  def up
  	add_column :courses, :current_students_qty, :integer, :after => :students_qty, :default => 0
  end

  def down
  	remove_column :courses, :current_students_qty
  end
end
