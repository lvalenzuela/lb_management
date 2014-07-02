class CreateLastRequestMessageChecks < ActiveRecord::Migration
  def up
    create_table :last_request_message_checks do |t|
      t.integer :requestid
      t.integer :userid
      t.datetime :last_check_datetime
      t.timestamps
    end
    add_column :requests, :last_msg_datetime,   :datetime
    drop_table :request_messages
  end

  def down
  	drop_table :last_request_message_checks
  	remove_column :requests, :last_msg_datetime
  end
end
