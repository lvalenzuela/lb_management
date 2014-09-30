class ModifyCoursesDetails < ActiveRecord::Migration
  def up
  	rename_column :courses, :coursetemplateid, :course_template_id
  end

  def down
  	rename_column :courses, :course_template_id, :coursetemplateid
  end
end
