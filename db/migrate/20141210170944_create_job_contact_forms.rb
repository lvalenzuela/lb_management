class CreateJobContactForms < ActiveRecord::Migration
  def up
    create_table :job_contact_forms do |t|
    	t.string :name
    	t.string :university
    	t.string :address
    	t.string :location
    	t.string :email
    	t.string :phone
    	t.string :job_choice
    	t.attachment :attached_resume
    	t.string :subject
    	t.text :msg
      t.timestamps
    end
  end

  def down
  	drop_table :job_contact_forms
  end
end
