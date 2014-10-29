class AddClassroomMatchingIdToCourses < ActiveRecord::Migration
  def up
  	add_column :courses, :classroom_matching_id, :integer, :after => :end_date
  end

  def down
  	remove_column :courses, :classroom_matching_id
  end
end
