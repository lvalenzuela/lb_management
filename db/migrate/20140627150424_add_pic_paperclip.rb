class AddPicPaperclip < ActiveRecord::Migration
	def self.up
		add_column :requests, :pic_file_name,    :string
		add_column :requests, :pic_content_type, :string
		add_column :requests, :pic_file_size,    :integer
		add_column :requests, :pic_updated_at,   :datetime
	end

	def self.down
		remove_column :requests, :pic_file_name
		remove_column :requests, :pic_content_type
		remove_column :requests, :pic_file_size
		remove_column :requests, :pic_updated_at
	end
end
