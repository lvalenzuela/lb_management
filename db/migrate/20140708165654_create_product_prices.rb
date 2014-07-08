class CreateProductPrices < ActiveRecord::Migration
  def up
    create_table :product_prices do |t|
    	t.integer :modalityid
    	t.integer :students_qty
    	t.integer :hours_amt
    	t.integer :price
      	t.timestamps
    end
  end

  def down
  	drop_table :product_prices
  end
end
