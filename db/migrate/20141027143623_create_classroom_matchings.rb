class CreateClassroomMatchings < ActiveRecord::Migration
  def up
    create_table :classroom_matchings do |t|
    	t.string :matching_array
      t.timestamps
    end
  end

  def down
  	drop_table :classroom_matchings
  end
end
