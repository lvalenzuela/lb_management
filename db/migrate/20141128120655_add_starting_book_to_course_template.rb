class AddStartingBookToCourseTemplate < ActiveRecord::Migration
  def up
  	add_column :course_templates, :starting_book, :boolean, :after => :total_sessions, :default => false
  end

  def down
  	remove_column :course_templates, :starting_book
  end
end
