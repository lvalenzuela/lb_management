class CreateModalities < ActiveRecord::Migration
  def up
    create_table :modalities do |t|
    	t.string :modalityname
    	t.string :description
 	    t.timestamps
    end
  end

  def down
  	drop_table :modalities
  end
end
