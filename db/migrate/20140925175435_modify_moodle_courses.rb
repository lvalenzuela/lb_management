class ModifyMoodleCourses < ActiveRecord::Migration
  def up
  	add_column :moodle_courses, :status_id, :integer, after: :course_template_id
  	add_column :moodle_courses, :location_id, :integer, after: :status_id
  	add_column :moodle_courses, :start_date, :date, after: :location_id
  	add_column :moodle_courses, :end_date, :date, after: :start_date
  end

  def down
  	remove_column :moodle_courses, :status_id
  	remove_column :moodle_courses, :location_id
  	remove_column :moodle_courses, :start_date
  	remove_column :moodle_courses, :end_date
  end
end
