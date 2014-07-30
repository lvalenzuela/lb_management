class CreateZohoDefaultTemplates < ActiveRecord::Migration
  def up
    create_table :zoho_default_templates do |t|
    	t.string :invoice_template_id
    	t.string :estimate_template_id
    	t.string :creditnote_template_id
    	t.string :invoice_email_template_id
    	t.string :estimate_email_template_id
    	t.string :creditnote_email_template_id
      t.timestamps
    end
  end

  def down
  	drop_table :zoho_default_templates
  end
end
