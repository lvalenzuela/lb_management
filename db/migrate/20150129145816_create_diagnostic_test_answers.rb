class CreateDiagnosticTestAnswers < ActiveRecord::Migration
  def up
    create_table :diagnostic_test_answers do |t|
      t.integer :num_resp
      t.string :correcta
      t.string :a
      t.string :b
      t.string :c
      t.string :d
      t.string :e
      t.timestamps
    end
  end

  def down
  	drop_table :diagnostic_test_answers
  end
end
