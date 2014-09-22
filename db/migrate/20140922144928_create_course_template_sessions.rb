class CreateCourseTemplateSessions < ActiveRecord::Migration
  def up
    create_table :course_template_sessions do |t|
    	t.integer :course_template_id
    	t.integer :session_number
    	t.integer :session_type_id
    	t.integer :page
    	t.string :contents
      	t.timestamps
    end
  end

  def down
  	drop_table :course_template_sessions
  end
end
