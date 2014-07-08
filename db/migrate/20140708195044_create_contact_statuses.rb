class CreateContactStatuses < ActiveRecord::Migration
  def up
    create_table :contact_statuses do |t|
    	t.string :statusname
    	t.string :description
      t.timestamps
    end
  end

  def down
  	drop_table :contact_statuses
  end
end
