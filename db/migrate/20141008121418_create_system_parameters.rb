class CreateSystemParameters < ActiveRecord::Migration
  def up
    create_table :system_parameters do |t|
    	t.string :param_name
    	t.string :description
    	t.string :param_value
      	t.timestamps
    end
    #primer registro de parametros del sistema
    SystemParameter.create(	:param_name => "request_auto_confirm_time", 
    						:description => "Máximo tiempo (en semanas) a esperar para confirmar automáticamente una solicitud que esta esperando confirmación.",
    						:param_value => "2")
  end

  def down
  	drop_table :system_parameters
  end
end
