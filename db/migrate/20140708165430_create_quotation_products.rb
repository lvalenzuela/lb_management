class CreateQuotationProducts < ActiveRecord::Migration
  def up
    create_table :quotation_products do |t|
    	t.integer :quotationid
    	t.integer :productid
      	t.timestamps
    end
  end

  def down
  	drop_table :quotation_products
  end
end
