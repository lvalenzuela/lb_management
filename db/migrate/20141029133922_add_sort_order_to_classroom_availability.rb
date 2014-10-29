class AddSortOrderToClassroomAvailability < ActiveRecord::Migration
  def up
  	add_column :classroom_availabilities, :sort_order, :integer, :after => :id
  end

  def down
  	remove_column :classroom_availabilities, :sort_order
  end
end
