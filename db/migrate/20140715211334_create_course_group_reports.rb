class CreateCourseGroupReports < ActiveRecord::Migration
  def up
    create_table :course_group_reports do |t|
    	t.integer :groupid
    	t.integer :userid
    	t.string :firstname
    	t.string :lastname
    	t.string :institution
    	t.string :department
    	t.string :username
    	t.date :lastaccess
    	t.integer :total_sessions
    	t.integer :current_sessions
    	t.integer :p_sessions
    	t.integer :a_sessions
    	t.integer :t_sessions
    	t.decimal :avg_inclasswork, :precision => 5, :scale => 2
    	t.decimal :avg_attitude, :precision => 5, :scale => 2
    	t.decimal :grade_coursegroup, :precision => 5, :scale => 2
    	t.decimal :grade_homework, :precision => 5, :scale => 2
    	t.decimal :grade_writing_tests, :precision => 5, :scale => 2
    	t.decimal :grade_tests_teg, :precision => 5, :scale => 2
    	t.decimal :grade_tests, :precision => 5, :scale => 2
    	t.decimal :grade_oral_tests, :precision => 5, :scale => 2
    	t.integer :assignments_ontime
    	t.integer :total_assignments
      	t.timestamps
    end
  end

  def down
  	drop_table :course_group_reports
  end
end
