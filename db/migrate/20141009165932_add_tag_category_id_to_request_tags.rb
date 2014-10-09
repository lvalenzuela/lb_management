class AddTagCategoryIdToRequestTags < ActiveRecord::Migration
  def up
  	add_column :request_tags, :category_id, :integer, :after => :id, :default => 1
  end

  def down
  	remove_column :request_tags, :category_id
  end
end
