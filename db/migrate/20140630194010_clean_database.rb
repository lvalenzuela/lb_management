class CleanDatabase < ActiveRecord::Migration
  def change
  	drop_table :request_areas
  	drop_table :request_tags
  	drop_table :user_types
  end
end
