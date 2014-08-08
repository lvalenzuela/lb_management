class CreateCourseMembers < ActiveRecord::Migration
  def up
    create_table :course_members do |t|
    	t.integer :course_id
    	t.integer :contact_person_id
      	t.timestamps
    end
  end

  def down
  	drop_table :course_members
  end
end
