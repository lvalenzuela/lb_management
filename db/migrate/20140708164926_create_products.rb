class CreateProducts < ActiveRecord::Migration
  def up
    create_table :products do |t|
    	t.integer :productpriceid
    	t.integer :courseid
    	t.integer :students_qty
      	t.timestamps
    end
  end

  def down
  	drop_table :products
  end
end
