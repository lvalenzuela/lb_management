class AddTemplateIdToMoodleCourses < ActiveRecord::Migration
  def up
  	add_column :moodle_courses, :course_template_id, :integer, after: :coursename
  end

  def down
  	remove_column :moodle_courses, :course_template_id
  end
end
