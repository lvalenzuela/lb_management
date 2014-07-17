class ChangeCreationDateCourseGroupReports < ActiveRecord::Migration
  def up
  	change_column :course_group_reports, :created_at, :date
  end

  def down
  	change_column :course_group_reports, :created_at, :datetime
  end
end
