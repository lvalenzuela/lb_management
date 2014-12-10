class CreateWebContactForms < ActiveRecord::Migration
  def up
    create_table :web_contact_forms do |t|
    	t.string :name
    	t.string :email
    	t.string :phone
    	t.string :subject
    	t.text :msg
		t.timestamps
    end
  end

  def down
  	drop_table :web_contact_forms
  end
end
