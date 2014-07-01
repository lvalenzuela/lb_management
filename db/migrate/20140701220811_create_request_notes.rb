class CreateRequestNotes < ActiveRecord::Migration
  def up
    create_table :request_notes do |t|
      t.integer :requestid
      t.integer :userid
      t.string :subject
      t.text :message
      t.string :attach_file_name
      t.string :attach_content_type
      t.integer :attach_file_size
      t.datetime :attach_updated_at
      t.timestamps
    end
  end

  def down
  	drop_table :request_notes
  end
end
