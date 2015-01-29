class CreateDiagnosticTestLevels < ActiveRecord::Migration
  def up
    create_table :diagnostic_test_levels do |t|
		t.string :sigla
		t.string :nombre
		t.timestamps
    end
  end

  def down
  	drop_table :diagnostic_test_levels
  end
end
