class AddSessionsToTemplate < ActiveRecord::Migration
  def up
  	add_column :course_templates, :total_sessions, :integer, after: :name
  end

  def down
  	remove_column :course_templates, :total_sessions
  end
end
