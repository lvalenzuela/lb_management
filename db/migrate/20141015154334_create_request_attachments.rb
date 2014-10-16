class CreateRequestAttachments < ActiveRecord::Migration
  def up
    create_table :request_attachments do |t|
    	t.integer :request_id
    	t.attachment :attached_file
      	t.timestamps
    end
  end

  def down
  	drop_table :request_attachments
  end
end
