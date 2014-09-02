class CreateRequestTags < ActiveRecord::Migration
  def up
    create_table :request_tags do |t|
    	t.integer :area_id
      t.integer :default_user_id
    	t.string :tagname
      	t.timestamps
    end
  end

  def down
	drop_table :request_tags
  end
end
