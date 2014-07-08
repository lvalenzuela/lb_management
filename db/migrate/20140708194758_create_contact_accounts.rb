class CreateContactAccounts < ActiveRecord::Migration
  def up
    create_table :contact_accounts do |t|
    	t.string :accountname
    	t.string :description
    	t.integer :type
      t.timestamps
    end
  end

  def down
  	drop_table :contact_accounts
  end
end
