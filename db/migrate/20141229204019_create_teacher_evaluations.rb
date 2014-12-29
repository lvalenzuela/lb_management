class CreateTeacherEvaluations < ActiveRecord::Migration
  def up
    create_table :teacher_evaluations do |t|
    	t.date :evaluation_date
		t.timestamps
    end
  end

  def down
  	drop_table :teacher_evaluations
  end
end
