class CreateQuotations < ActiveRecord::Migration
  def up
    create_table :quotations do |t|
    	t.integer :clientid
    	t.integer :productid
    	t.decimal :discount
    	t.integer :price
    	t.integer :statusid
      	t.timestamps
    end
  end

  def down
  	drop_table :quotations
  end
end
