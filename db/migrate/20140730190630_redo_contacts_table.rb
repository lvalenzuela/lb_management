class RedoContactsTable < ActiveRecord::Migration
  def up
    drop_table :contacts
    
  	create_table :contacts do |t|
    	t.string :fistname
    	t.string :lastname
    	t.integer :payment_terms
    	t.string :payment_terms_label
    	t.string :currency_id
    	t.string :website
      t.string :rut
      t.string :address
      t.string :city
      t.string :country
      t.string :zip
      t.string :phone
    	t.integer :zoho_default_template_id
    	t.string :notes
    	t.timestamps
    end
  end

  def down
  	drop_table :contacts
  end
end
