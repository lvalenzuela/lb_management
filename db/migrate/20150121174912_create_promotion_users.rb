class CreatePromotionUsers < ActiveRecord::Migration
  def up
    create_table :promotion_users do |t|
    	t.integer :promotion_id
    	t.integer :user_id
    	t.integer :promotion_attribute_id
    	t.string :attribute_value
		t.timestamps
    end	
  end

  def down
  	drop_table :promotion_users
  end
end
