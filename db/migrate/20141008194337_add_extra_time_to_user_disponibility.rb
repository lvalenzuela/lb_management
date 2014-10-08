class AddExtraTimeToUserDisponibility < ActiveRecord::Migration
  def up
  	add_column :user_disponibilities, :extra_start_time, :time, :after => :end_time
  	add_column :user_disponibilities, :extra_end_time, :time, :after => :extra_start_time
  end

  def down
  	remove_column :user_disponibilities, :extra_start_time
  	remove_column :user_disponibilities, :extra_end_time
  end
end
