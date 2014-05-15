class CreateGradeGrades < ActiveRecord::Migration
  def change
    create_table :grade_grades do |t|

      t.timestamps
    end
  end
end
