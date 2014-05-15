class DocumentPdf < Prawn::Document
	include ReportsHelper

	def initialize(params,view_context)
		super(:margin => 50)
		font "Helvetica"
		header
		move_down 20
		general_data(params)
		attendance(params)
		indicadores_academicos(params)
		#responsabilidad(params)
		footer
	end
	#para definir templates ver la seccion de "repeatable_content" del manual

	def header
		logo_path = Rails.root.join('app','assets','images','longbourn_logo.png')
		image logo_path, :width => 70, :height => 45, :at => [0,720]
		move_down 10
		draw_text "Informe de Desempeño de Alumnos", :at => [100, 700], size:12
		draw_text "Longbourn Institute", :at => [100, 685], size:12
	end

	def general_data(params)
		usuario = User.where(:id => params[:user_id])
		curso = Course.where(:id => params[:course_id])
		data = [["<b>Nombre</b>",usuario.first().firstname+' '+usuario.first().lastname],
				["<b>Empresa</b>",usuario.first().institution],
				["<b>Curso</b>",curso.first().fullname],
				["<b>Fecha</b>", Date.today()]]

		table(data, :column_widths => {0 => 80, 1 => 300}, :cell_style => {:size => 12,:borders => [], :inline_format => true, :padding => [0,0]}, :position => :left)
	end

	def attendance(params)
		att_sessions = get_att_sessions(params[:course_id])
		user_att = user_att_info(params[:user_id],params[:course_id])

		att_pct = user_att.presente.to_f*100/user_att.clases_dictadas.to_f

		att_pct = att_pct.round(2)

		move_down 20
		font "Helvetica", :style => :bold
		text "1. Indicadores de Asistencia"
		font "Helvetica", :style => :normal
		move_down 10
		data = []	#datos de la tabla
		data << ["<b>Clases Presente</b>", "<b>Clases Ausente</b>", "<b>Atrasos<br>(Sobre 15 minutos)</b>", "<b>Clases Realizadas</b>", "<b>Porcentaje de Asistencia<b>"]	#encabezado de la tabla
		data << [user_att.presente.to_s, user_att.ausente.to_s, user_att.tarde.to_s, user_att.presente.to_s+" de "+att_sessions.to_s, "<b>"+att_pct.to_s+"%</b>"]
		table(data, :column_widths => {0 => 100, 1 => 100, 2 => 100, 3 => 100, 4 => 100}, 
					:cell_style => {:align => :center,:size => 10, :border_width => 1, :inline_format => true, :padding => [5,5]}, 
					:position => :center,
					:row_colors => ["F0F0F0","FFFFFF"]) do
			cells.style do |c|
				if c.row == 1 && c.column == 4
					c.background_color = "F0F0F0"
				end
				if c.row == 1
					c.padding = 10
				end
			end
		end

		inatt_pct = user_att.ausente.to_f*100/user_att.clases_dictadas.to_f
		late_pct = user_att.tarde.to_f*100/user_att.clases_dictadas.to_f
		inatt_late_pct = inatt_pct + late_pct

		inatt_pct = inatt_pct.round(2)
		late_pct = late_pct.round(2)
		inatt_late_pct = inatt_late_pct.round(2)

		move_down 10
		data = [] #datos para la segunda tabla
		data << ["<b>Porcentaje de Inasistencia</b>",inatt_pct.to_s+"%"]
		data << ["<b>Porcentaje de Atrasos</b>", late_pct.to_s+"%"]
		data << ["<b>Total Porcentaje de Inasistencias y Atrasos</b>", inatt_late_pct.to_s+"%"]
		table(data, :column_widths => {0 => 300, 1 => 200},
					:cell_style => {:align => :center,:size => 10, :border_width => 1, :inline_format => true, :padding => [10,10]}, 
					:position => :center) do
			cells.style do |c|
				if c.column == 0
					c.background_color = "F0F0F0"
				end
				if c.column == 1 && c.row == 2
					c.background_color = "F0F0F0"
				end
			end
		end

		inatt_limit = att_sessions/4
		inatt_total = (user_att.ausente+user_att.tarde)

		move_down 20
		font "Helvetica", :style => :bold
		text "<u>Observaciones</u>", :inline_format => true
		font "Helvetica", :style => :normal
		indent(60) do
			text "Para hacer uso de la Franquicia Sence, al final del curso la suma de porcentaje de inasistencias y atrasos debe ser menor o igual al 25%(<b>"+inatt_limit.to_s+" clases</b> en el caso de este curso de ingles).", :inline_format => true
		end
		move_down 10
		if inatt_total < inatt_limit
			indent(60) do
				text "Si el alumno se ausenta o se atrasa <b>"+(inatt_limit - inatt_total).to_s+" veces</b> en lo que resta del curso, no cumplirá con el 75% de asistencia exigido por la Franquicia Sence", :inline_format => true
			end
		else
			indent(60) do
				text "El alumno actualmente no cumple con el mínimo de 75% de asistencia exigido por la Franquicia Sence (<b>"+inatt_total.to_s+"</b> inasistencias y atrasos)", :inline_format => true
			end
		end
	end

	def indicadores_academicos(params)
		grades = find_grades(params[:user_id],params[:course_id])

		move_down 20
		font "Helvetica", :style => :bold
		text "2. Indicadores Academicos"
		font "Helvetica", :style => :normal
		move_down 10
		data = [] #datos para la tabla
		data << ["<b>Homework</b><br>30%","<b>Writing Test</b><br>20%","<b>Tests T.E.G</b><br>20%","<b>Tests</b><br>15%","<b>Oral Test</b><br>15%","<b>Promedio Parcial</b>"]
		data << [grade_parser(grades.homework), grade_parser(grades.writing_test), grade_parser(grades.tests_teg), grade_parser(grades.tests), grade_parser(grades.oral_tests), "<b>"+grade_promedio(grades).to_s+"</b>"]
		table(data, :column_widths => {0 => 83, 1 => 83, 2 => 83, 3 => 83, 4 => 83, 5 => 83},
			:cell_style => {:align => :center,:size => 10, :border_width => 1, :inline_format => true, :padding => [5,5]}, 
			:position => :center) do
			cells.style do |c|
				if c.row == 0
					c.background_color = "F0F0F0"
				end
				if c.row == 1 && c.column == 5
					c.background_color = "F0F0F0"
				end
			end
		end
	end

	def responsabilidad(contenido)
		move_down 20
		font "Helvetica", :style => :bold
		text "3. Indicadores de Responsabilidad"
		font "Helvetica", :style => :normal
		move_down 10
		data = []
		data << ["<b>Trabajo en Clases</b>","<b>Entrega de Tareas Evaluadas</b>", "<b>Último acceso al Sitio Web Longbourn</b>"]
		data << ["Suficiente, pero se recomienda mejorar", "90,0% de las tareas entregadas a tiempo", "1 vez por semana"]
		table(data, :column_widths => {0 => 166, 1 => 166, 2 => 166},
			:cell_style => {:align => :center,:size => 10, :border_width => 1, :inline_format => true, :padding => [5,5]}, 
			:position => :center) do
			cells.style do |c|
				if c.row == 0
					c.background_color = "F0F0F0"
				end
			end
		end
	end

	def footer
		move_cursor_to 30
		font "Helvetica", :size => 9
		text "Badajoz 130 Oficina 405, esquina Alonso de Córdova, Las Condes", :align => :center
		text "Fono:(56-2)2951 1482 - Correo: contacto@longbourn.cl", :align => :center
		text "www.longbourn.cl", :align => :center
	end

end