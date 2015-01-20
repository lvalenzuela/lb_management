class CreatePromotions < ActiveRecord::Migration
  def up
    create_table :promotions do |t|
    	t.string :shortname
    	t.string :fullname
    	t.string :description
    	t.date :start_date
    	t.date :end_date
    	t.decimal :discount_index, :precision => 3, :scale => 2
		t.timestamps
    end
  end

  def down
  	drop_table :promotions
  end
end