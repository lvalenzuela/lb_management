class AdProductsColums < ActiveRecord::Migration
  def up
  	change_column :product_prices, :valid_until, :date
  	add_column :products, :courseid, :integer
  end

  def down
  	change_column :product_prices, :valid_until, :datetime
  	drop_column :products, :courseid
  end
end
