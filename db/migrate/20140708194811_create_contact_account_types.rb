class CreateContactAccountTypes < ActiveRecord::Migration
  def up
    create_table :contact_account_types do |t|
    	t.string :typename
    	t.string :description
      t.timestamps
    end
  end

  def down
  	drop_table :contact_account_types
  end
end
