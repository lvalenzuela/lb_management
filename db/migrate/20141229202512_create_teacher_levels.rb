class CreateTeacherLevels < ActiveRecord::Migration
  def up
    create_table :teacher_levels do |t|
    	t.string :level_label
    	t.string :description
      t.timestamps
    end
  end

  def down
  	drop_table :teacher_levels
  end
end
