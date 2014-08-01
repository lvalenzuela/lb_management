class CreateZohoInvoices < ActiveRecord::Migration
  def up
    create_table :zoho_invoices do |t|
    	t.integer :contact_id
    	t.string :zoho_contact_id
    	t.string :zoho_invoice_id
      	t.timestamps
    end
  end

  def down
  	drop_table :zoho_invoices
  end
end
