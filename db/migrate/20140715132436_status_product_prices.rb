class StatusProductPrices < ActiveRecord::Migration
  def up
  	add_column :product_prices, :deleted, :boolean, :default => 0
  end

  def down
  	remove_column :product_prices, :deleted
  end
end
