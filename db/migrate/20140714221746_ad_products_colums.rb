class AdProductsColums < ActiveRecord::Migration
  def up
  	change_column :product_prices, :valid_until, :date
  end

  def down
  	change_column :product_prices, :valid_until, :datetime
  end
end
