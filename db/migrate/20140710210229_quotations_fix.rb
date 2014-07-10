class QuotationsFix < ActiveRecord::Migration
  def up
  	add_column :quotations, :comments, :text
  	remove_column :quotations, :productid
  end

  def down
  	add_column :quotations, :productid, :integer
  	remove_column :quotations, :comments
  end
end
