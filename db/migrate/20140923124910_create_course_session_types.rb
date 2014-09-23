class CreateCourseSessionTypes < ActiveRecord::Migration
  def up
    create_table :course_session_types do |t|
    	t.string :type_name
    	t.string :description
      	t.timestamps
    end
  end

  def down
  	drop_table :course_session_types
  end
end
