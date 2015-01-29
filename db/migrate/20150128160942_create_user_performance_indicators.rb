class CreateUserPerformanceIndicators < ActiveRecord::Migration
  def up
  	#inicialmente orientado a medir el desempeño de los profesores,
  	#pero finalmente sera extendible a todos los usuarios
    create_table :user_performance_indicators do |t|
    	t.integer :user_id
    	t.integer :period_active_courses
    	t.integer :approving_on_grades
    	t.integer :approving_on_attendance
    	t.integer :courses_on_schedule
    	t.integer :mean_feedback_score
    	t.integer :main_evaluation_score
    	t.integer :period
    	t.integer :year
		t.timestamps
    end
  end

  def down
  	drop_table :user_performance_indicators
  end
end
