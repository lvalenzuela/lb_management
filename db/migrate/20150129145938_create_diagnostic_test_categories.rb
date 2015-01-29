class CreateDiagnosticTestCategories < ActiveRecord::Migration
  def up
    create_table :diagnostic_test_categories do |t|
    	t.string :nombre
		t.timestamps
    end
  end

  def down
  	drop_table :diagnostic_test_categories
  end
end
