class CreateUserTeacherLevels < ActiveRecord::Migration
  def up
    create_table :user_teacher_levels do |t|
    	t.string :level_label
    	t.string :description
      	t.timestamps
    end
  end

  def down
  	drop_table :user_teacher_levels
  end
end
