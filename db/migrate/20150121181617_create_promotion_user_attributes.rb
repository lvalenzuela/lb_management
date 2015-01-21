class CreatePromotionUserAttributes < ActiveRecord::Migration
  def up
    create_table :promotion_user_attributes do |t|
    	t.integer :promotion_id
    	t.string :attribute_name
    	t.string :attribute_description
      t.boolean :enabled
		t.timestamps
    end
  end

  def down
  	drop_table :promotion_user_attributes
  end
end
