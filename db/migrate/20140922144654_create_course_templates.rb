class CreateCourseTemplates < ActiveRecord::Migration
  def up
    create_table :course_templates do |t|
    	t.integer :course_level_id
    	t.string :name
    	t.timestamps
    end
  end

  def down
  	drop_table :course_templates
  end
end
