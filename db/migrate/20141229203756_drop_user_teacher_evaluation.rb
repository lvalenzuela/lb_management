class DropUserTeacherEvaluation < ActiveRecord::Migration
  def up
  	drop_table :user_teacher_levels
  end

  def down
  	#nada
  end
end
