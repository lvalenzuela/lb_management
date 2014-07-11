class QuotationDiscount < ActiveRecord::Migration
  def up
  	change_column :quotations, :discount, :decimal, :precision => 5, :scale => 2
  end

  def down
  	change_column :quotations, :discount, :decimal
  end
end
