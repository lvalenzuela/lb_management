class CreateCourseSessions < ActiveRecord::Migration
  def up
    create_table :course_sessions do |t|
    	t.integer :courseid
    	t.datetime :startdatetime
    	t.datetime :enddatetime
      	t.timestamps
    end
  end

  def down
  	drop_table :course_sessions
  end
end
