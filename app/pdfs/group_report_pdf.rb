class GroupReportPdf < Prawn::Document
	include ReportsHelper

	def initialize(institution, group_name, filter, view_context)
		super(:margin => 50)
		font "Helvetica"
		members = find_members(institution, group_name, filter)
		repeat :all do
			bounding_box [bounds.left, bounds.top + 30], :width  => bounds.width do
				header
			end

			bounding_box [bounds.left, bounds.bottom], :width  => bounds.width do
				footer
			end
		end

		bounding_box([bounds.left, bounds.top - 40], :width  => bounds.width, :height => bounds.height - 80) do
			font "Helvetica", :size => 12
			general_data(institution, group_name, filter)
			course_attendance(members, filter)
			indicadores_academicos(members, filter)
		end	

		number_pages "<page> de <total>",:at => [480, 0], size:9
	end

	def header
		logo_path = Rails.root.join('app','assets','images','longbourn_logo.png')
		image logo_path, :width => 70, :height => 45
		draw_text "Informe de Desempeño de Alumnos", :at => [100,25], size:12
		draw_text "Longbourn Institute", :at => [100,10], size:12
	end

	def footer
		move_cursor_to 30
		font "Helvetica", :size => 9
		text "Badajoz 130 Oficina 405, esquina Alonso de Córdova, Las Condes", :align => :center
		text "Fono:(56-2)2951 1482 - Correo: contacto@longbourn.cl", :align => :center
		text "www.longbourn.cl", :align => :center
	end

	def general_data(institution, group_name, filter)
		if filter.to_i == 1
			group = "Curso"
		else
			group = "Departamento"
		end
		font "Helvetica", :style => :bold
		text "Informe de Desempeño por "+group
		font "Helvetica", :style => :normal

		data = [["<b>"+group+"</b>",group_name],
				["<b>Empresa</b>",institution],
				["<b>Fecha</b>", Date.today()]]
		table(data, :column_widths => {0 => 90, 1 => 350}, :cell_style => {:size => 12,:borders => [], :inline_format => true, :padding => [0,0]}, :position => :left)
	end

	def course_attendance(members,filter)
		move_down 20
		font "Helvetica", :style => :bold
		text "1. Indicadores de Asistencia"
		font "Helvetica", :style => :normal
		move_down 10
		
		if filter.to_i == 1
			table_group = "Departamento"
		else
			table_group = "Curso"
		end

		data = []
		data << ["<b>Nombre</b>", "<b>"+table_group+"</b>", "<b>Presente</b>", "<b>Ausente</b>", "<b>Atrasos</b>", "<b>Clases Realizadas</b>", "<b>Asistencia<b>"]	#encabezado de la tabla		
		members.each do |member|
			att_sessions = get_att_sessions(member.courseid)
			user_att = user_att_info(member.userid, member.courseid)
			att_pct = (user_att.presente.to_f*100/user_att.clases_dictadas.to_f).round(2)

			if filter.to_i == 1
				member_group = member.department
			else
				member_group = member.course_fullname
			end
			data << [member.firstname+" "+member.lastname, member_group, user_att.presente.to_s, user_att.ausente.to_s, user_att.tarde.to_s, user_att.clases_dictadas.to_s+" de "+att_sessions.to_s, "<b>"+att_pct.to_s+"%</b>"]
		end

		table(data, :column_widths => {0 => 100, 1 => 100, 2 => 60, 3 => 60, 4 => 60, 5 => 65, 6 => 60}, 
					:cell_style => {:align => :center, :valign => :center,:size => 8, :border_width => 0.5, :inline_format => true, :padding => [5,5]}, 
					:position => :center,
					:header => true) do
			cells.style do |c|
				if c.row == 0
					c.background_color = "F0F0F0"
				end
			end
		end
	end

	def indicadores_academicos(members, filter)
		move_down 15
		font "Helvetica", :style => :bold
		text "2. Indicadores Academicos"
		font "Helvetica", :style => :normal
		move_down 10

		if filter.to_i == 1
			table_group = "Departamento"
		else
			table_group = "Curso"
		end

		data = []
		data << ["<b>Nombre</b>", "<b>"+table_group+"</b>","<b>Homework</b><br>30%","<b>Writing Test</b><br>20%","<b>Tests T.E.G</b><br>20%","<b>Tests</b><br>15%","<b>Oral Test</b><br>15%","<b>Promedio Parcial</b>"]
		members.each do |member|
			grades = find_grades(member.userid ,member.courseid)
			if filter.to_i == 1
				member_group = member.department
			else
				member_group = member.course_fullname
			end
			data << [member.firstname+" "+member.lastname, member_group, grade_parser(grades.homework), grade_parser(grades.writing_test), grade_parser(grades.tests_teg), grade_parser(grades.tests), grade_parser(grades.oral_tests), "<b>"+grade_promedio(grades).to_s+"</b>"]
		end
		table(data, :column_widths => {0 => 100, 1 => 100, 2 => 50, 3 => 55, 4 => 50, 5 => 50, 6 => 50, 7 => 50}, 
					:cell_style => {:align => :center, :valign => :center,:size => 8, :border_width => 0.5, :inline_format => true, :padding => [5,5]}, 
					:position => :center,
					:header => true) do
			cells.style do |c|
				if c.row == 0
					c.background_color = "F0F0F0"
				end
			end
		end
	end
end