class KpiEvaluationPeriod < ActiveRecord::Migration
  def up
  	new_parameter = SystemParameter.new()
  	new_parameter.param_name = "kpi_evaluation_period"
  	new_parameter.description = "Periodo de de evaluación de KPIs en meses."
  	new_parameter.param_value = 2 #cada 2 meses se realizará la evaluación de KPI para los profesores del sistema
  	new_parameter.save!
  end

  def down
  	#Eliminacion del parametro correspondiente al periodo de evaluacion de KPI
  	SystemParameter.find_by_param_name("kpi_evaluation_period").delete
  end
end
