class StudentReportPdf < Prawn::Document
	include ReportsHelper

	def initialize(user_id,course_id,view_context)
		super(:margin => 50)
		font "Helvetica"
		user_data = StudentV.find(user_id)
		report_data = UserReport.where(:userid => user_id, :courseid => course_id).order("created_at DESC").first()
		repeat :all do
			bounding_box [bounds.left, bounds.top + 30], :width  => bounds.width do
				header
			end

			bounding_box [bounds.left, bounds.bottom], :width  => bounds.width do
				footer
			end
		end

		bounding_box([bounds.left, bounds.top - 40], :width  => bounds.width, :height => bounds.height - 60) do
			font "Helvetica", :size => 12
			general_data(user_data,report_data)
			attendance(report_data)
			indicadores_academicos(report_data)
			responsabilidad(report_data)
		end

		number_pages "<page> de <total>",:at => [480, 0], size:9
	end
	#para definir templates ver la seccion de "repeatable_content" del manual

	def header
		logo_path = Rails.root.join('app','assets','images','longbourn_logo.png')
		image logo_path, :width => 70, :height => 45
		draw_text "Informe de Desempeño de Alumnos", :at => [100,25], size:12
		draw_text "Longbourn Institute", :at => [100,10], size:12
	end

	def general_data(user_data,report_data)
		data = [["<b>Nombre</b>",user_data.name],
				["<b>Empresa</b>",user_data.institution],
				["<b>Departamento</b>",user_data.department],
				["<b>Curso</b>",report_data.coursename],
				["<b>Fecha</b>", report_data.created_at.strftime("%d-%m-%Y")]]

		table(data, :column_widths => {0 => 90, 1 => 300}, :cell_style => {:size => 12,:borders => [], :inline_format => true, :padding => [0,0]}, :position => :left)
	end

	def attendance(report_data)
		if !report_data.p_sessions.nil? && !report_data.current_sessions.nil? && !report_data.a_sessions.nil? && !report_data.t_sessions.nil?
			att_pct = (report_data.p_sessions.to_f*100/report_data.current_sessions.to_f).round(2)
			inatt_pct = (report_data.a_sessions.to_f*100/report_data.current_sessions.to_f).round(2)
			late_pct = (report_data.t_sessions.to_f*100/report_data.current_sessions.to_f).round(2)
			inatt_late_pct = (inatt_pct + late_pct).round(2)
		else
			att_pct = 0
			report_data.p_sessions = 0
			report_data.current_sessions = 0
			report_data.a_sessions = 0
			report_data.t_sessions = 0
			inatt_pct = 0
			late_pct = 0
			inatt_late_pct = 0
		end

		move_down 10
		font "Helvetica", :style => :bold
		text "1. Indicadores de Asistencia"
		font "Helvetica", :style => :normal
		move_down 10
		data = []	#datos de la tabla
		data << ["<b>Clases Presente</b>", "<b>Clases Ausente</b>", "<b>Atrasos<br>(Sobre 15 minutos)</b>", "<b>Clases Realizadas</b>", "<b>Porcentaje de Asistencia<b>"]	#encabezado de la tabla
		data << [report_data.p_sessions.to_s, report_data.a_sessions.to_s, report_data.t_sessions.to_s, report_data.current_sessions.to_s+" de "+report_data.total_sessions.to_s, "<b>"+att_pct.to_s+"%</b>"]
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

		inatt_limit = report_data.total_sessions/4	
		if !report_data.a_sessions.nil? || !report_data.t_sessions.nil?
			inatt_total = (report_data.a_sessions+report_data.t_sessions)
		else
			inatt_total = 0
		end

		c = MoodleCourse.find_by_moodleid(report_data.courseid)
		if c.sence
			sence_attendance_text(inatt_total, inatt_limit)
		end
	end

	def indicadores_academicos(report_data)

		move_down 15
		font "Helvetica", :style => :bold
		text "2. Indicadores Academicos"
		font "Helvetica", :style => :normal
		move_down 10
		data = [] #datos para la tabla
		data << ["<b>Homework</b><br>30%","<b>Writing Test</b><br>20%","<b>Tests T.E.G</b><br>20%","<b>Tests</b><br>15%","<b>Oral Test</b><br>15%","<b>Promedio</b>"]
		data << [grade_parser(report_data.grade_homework), grade_parser(report_data.grade_writing_tests), grade_parser(report_data.grade_tests_teg), grade_parser(report_data.grade_tests), grade_parser(report_data.grade_oral_tests), "<b>"+grade_parser(report_data.grade_course)+"</b>"]
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

	def responsabilidad(report_data)
		if !report_data.total_assignments.nil?
			assignment_value = (report_data.assignments_ontime.to_f*100/report_data.total_assignments.to_f).round(2)
			assignment_txt = assignment_value.to_s+"% de las tareas entregadas a tiempo"
		else
			assignment_txt = "No hay entregas de tareas registradas a la fecha."
		end

		if !report_data.lastaccess.nil?
			lastaccess = report_data.lastaccess.strftime("%d-%m-%Y %I:%M %p")
		else
			lastaccess = "-"
		end

		move_down 15
		font "Helvetica", :style => :bold
		text "3. Indicadores de Responsabilidad"
		font "Helvetica", :style => :normal
		move_down 10
		data = []
		data << ["<b>Trabajo en Clases</b>","<b>Entrega de Tareas Evaluadas</b>", "<b>Último acceso al Sitio Web Longbourn</b>"]
		data << [get_resp_info(report_data.avg_inclasswork), assignment_txt, lastaccess]
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

	private

	def sence_attendance_text(inatt_total, inatt_limit)
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
end