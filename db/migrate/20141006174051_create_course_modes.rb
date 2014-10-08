class CreateCourseModes < ActiveRecord::Migration
  def up
    create_table :course_modes do |t|
    	t.string :mode_name
    	t.string :description
    	t.boolean :enabled
      	t.timestamps
    end
  end

  def down
  	drop_table :course_modes
  end
end
