class CreateCourseLevels < ActiveRecord::Migration
  def up
    create_table :course_levels do |t|
    	t.string :course_level
    	t.string :description
      	t.timestamps
    end
  end

  def down
  	drop_table :course_levels
  end
end
