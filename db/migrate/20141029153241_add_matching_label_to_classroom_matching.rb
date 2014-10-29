class AddMatchingLabelToClassroomMatching < ActiveRecord::Migration
  def up
  	add_column :classroom_matchings, :matching_label, :string, :after => :matching_array
  end

  def down
  	remove_column :classroom_matchings, :matching_label
  end
end
