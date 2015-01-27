class AddSortOrderToPromotionUserAttributes < ActiveRecord::Migration
  def up
  	add_column :promotion_user_attributes, :sort_order, :integer, :after => :id
  end

  def down
  	delete_column :promotion_user_attributes, :sort_order
  end
end
