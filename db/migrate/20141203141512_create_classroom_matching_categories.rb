class CreateClassroomMatchingCategories < ActiveRecord::Migration
  def up
    create_table :classroom_matching_categories do |t|
    	t.string :name
    	t.string :description
      	t.timestamps
    end
  end

  def down
  	create_table :classroom_matching_categories
  end
end
