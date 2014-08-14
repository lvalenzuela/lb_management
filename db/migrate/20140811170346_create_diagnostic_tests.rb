class CreateDiagnosticTests < ActiveRecord::Migration
  def up
    create_table :diagnostic_tests do |t|
    	t.integer :contact_person_id
    	t.integer :score
      	t.timestamps
    end
  end

  def down
  	drop_table :diagnostic_tests
  end
end
