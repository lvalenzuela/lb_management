class CreateContactPeople < ActiveRecord::Migration
  def up
    create_table :contact_people do |t|
    	t.integer :contact_id
    	t.string :gender
    	t.string :salutation
    	t.string :firstname
    	t.string :lastname
    	t.string :email
    	t.string :phone
    	t.string :mobile
    	t.boolean :is_primary_contact
      	t.timestamps
    end
  end

  def down
  	drop_table :contact_people
  end
end
