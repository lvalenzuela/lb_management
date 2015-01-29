class CreateDiagnosticTestQuestions < ActiveRecord::Migration
  def up
    create_table :diagnostic_test_questions do |t|
      t.text :enunciado
      t.integer :category_id
      t.integer :level_id
      t.integer :answer_id
      t.integer :numero
      t.timestamps
    end
  end

  def down
  	drop_table :diagnostic_test_questions
  end
end
