class AddDeletedStatusToCourseTemplate < ActiveRecord::Migration
  def up
  	add_column :course_templates, :deleted, :integer, :default => 0
  end

  def down
  	remove_column :course_templates, :deleted
  end
end
