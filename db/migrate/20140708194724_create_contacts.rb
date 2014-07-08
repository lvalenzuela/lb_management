class CreateContacts < ActiveRecord::Migration
  def up
    create_table :contacts do |t|
    	t.integer :accountid
    	t.string :institution
    	t.string :firstname
    	t.string :lastname
    	t.string :rut
    	t.string :email
    	t.integer :phone
    	t.integer :typeid
    	t.integer :statusid
      t.timestamps
    end
  end

  def down
  	drop_table :contacts
  end
end
