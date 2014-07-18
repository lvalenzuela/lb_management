class CreateRequestDefaultTitles < ActiveRecord::Migration
  def up
    create_table :request_default_titles do |t|
    	t.integer :areaid
    	t.string :title
      	t.timestamps
    end
  end

  def down
  	drop_table :request_default_titles
  end
end
