class ChangeDiscountIndex < ActiveRecord::Migration
  def up
  	change_column :promotions, :discount_index, :integer
  end

  def down
  	change_column :promotions, :discount_index, :decimal, :precision => 3, :scale => 2
  end
end
