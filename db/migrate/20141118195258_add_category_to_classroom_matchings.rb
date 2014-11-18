class AddCategoryToClassroomMatchings < ActiveRecord::Migration
  def up
  	add_column :classroom_matchings, :category_id, :integer, :after => :enabled, :default => 0
  end

  def down
  	remove_column :classroom_matchings, :category_id
  end
end
