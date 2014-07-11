class ModalityProductPrices < ActiveRecord::Migration
  def up
  	rename_column :product_prices, :modalityid, :modality
  	change_column :product_prices, :modality, :string
  	add_column :product_prices, :valid_until, :datetime
  end

  def down
  	rename_column :product_prices, :modality, :modalityid
  	change_column :product_prices, :modalityid, :integer
  	remove_column :product_prices, :valid_until
  end
end
