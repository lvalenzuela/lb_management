class AddOverallCapacityToClassroomMatchings < ActiveRecord::Migration
  def up
  	add_column :classroom_matchings, :max_capacity, :integer, :after => :matching_label
  end

  def down
  	remove_column :classroom_matchings, :max_capacity
  end
end
