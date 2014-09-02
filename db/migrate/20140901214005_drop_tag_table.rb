class DropTagTable < ActiveRecord::Migration
  def up
  	drop_table :tags
  end

  def down
  	create_table :tags do |t|
  		t.timestamps
  	end
  end
end
