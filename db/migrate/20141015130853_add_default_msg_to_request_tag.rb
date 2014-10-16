class AddDefaultMsgToRequestTag < ActiveRecord::Migration
  def up
  	add_column :request_tags, :default_msg, :text, :after => :tagname
  end

  def down
  	remove_column :request_tags, :default_msg
  end
end
