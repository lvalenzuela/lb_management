class CourseGroupReportPdf < Prawn::Document

	def initialize(group, view_context)
		super(:margin => 50)
		font "Helvetica"
		members = find_group_members(group.id)
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
			general_data(group)
			course_attendance(members, group)
			indicadores_academicos(members, group)
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

	def general_data(group)
		font "Helvetica", :style => :bold
		text "Informe de Desempeño por Curso"
		font "Helvetica", :style => :normal

		data = [["<b>Curso</b>", group.groupname],
				["<b>Fecha</b>", Date.today()]]
		table(data, :column_widths => {0 => 90, 1 => 350}, :cell_style => {:size => 12,:borders => [], :inline_format => true, :padding => [0,0]}, :position => :left)
	end

	def course_attendance(members, group)
		move_down 20
		font "Helvetica", :style => :bold
		text "1. Indicadores de Asistencia"
		font "Helvetica", :style => :normal
		move_down 10

		data = []
		data << ["<b>Nombre</b>", "<b>Presente</b>", "<b>Ausente / Tarde</b>", "<b>F.S.(*)</b>", "<b>Clases Realizadas</b>", "<b>Asistencia<b>"]	#encabezado de la tabla		
		members.each do |member|
			member_data = CourseGroupReport.where(:userid => member.userid, :groupid => group.id).order("created_at DESC").first()
			att_pct = (member_data.p_sessions.to_f*100/member_data.current_sessions.to_f).round(2)
			
			if !member_data.a_sessions.nil? && !member_data.t_sessions.nil? && !member_data.p_sessions.nil?
				a_sessions = member_data.a_sessions + member_data.t_sessions
			else
				a_sessions = 0
				member_data.p_sessions = 0
				member_data.current_sessions = 0
				att_pct = 0
			end
			
			total_sence = member_data.total_sessions/4
			r_sence = total_sence-a_sessions
			if r_sence < 0
				sence = "No Aplica"
			else
				sence = r_sence
			end

			data << [member_data.firstname+" "+member_data.lastname, member_data.p_sessions.to_s, a_sessions.to_s, sence.to_s, member_data.current_sessions.to_s+" de "+member_data.total_sessions.to_s, "<b>"+att_pct.to_s+"%</b>"]
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
		move_down 10
		text "<b>(*)</b> Clases restantes a las que el alumno puede ausentarse y seguir cumpliendo con la Franquicia Sence (Máximo 25% del total).", size:9, :inline_format => true
	end

	def indicadores_academicos(members, group)
		move_down 15
		font "Helvetica", :style => :bold
		text "2. Indicadores Academicos"
		font "Helvetica", :style => :normal
		move_down 10

		data = []
		data << ["<b>Nombre</b>","<b>Homework</b><br>30%","<b>Writing Test</b><br>20%","<b>Tests T.E.G</b><br>20%","<b>Tests</b><br>15%","<b>Oral Test</b><br>15%","<b>Promedio Parcial</b>"]
		members.each do |member|
			member_data = CourseGroupReport.where(:userid => member.userid, :groupid => group.id).order("created_at DESC").first()

			data << [member_data.firstname+" "+member_data.lastname, grade_parser(member_data.grade_homework), grade_parser(member_data.grade_writing_tests), grade_parser(member_data.grade_tests_teg), grade_parser(member_data.grade_tests), grade_parser(member_data.grade_oral_tests), "<b>"+grade_parser(member_data.grade_coursegroup)+"</b>"]
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

	private

	def find_group_members(groupid)
		return members = CourseGroupReport.where(:groupid => groupid).select("userid")
	end

	def grade_parser(grade)
		#transforma notas desde una escala de 0 a 61 a la escala chilena
		scale = ['1,0','1,1','1,2','1,3','1,4','1,5','1,6','1,7','1,8','1,9','2,0','2,1','2,2','2,3','2,4','2,5','2,6','2,7','2,8','2,9','3,0','3,1','3,2','3,3','3,4','3,5','3,6','3,7','3,8','3,9','4,0','4,1','4,2','4,3','4,4','4,5','4,6','4,7','4,8','4,9','5,0','5,1','5,2','5,3','5,4','5,5','5,6','5,7','5,8','5,9','6,0','6,1','6,2','6,3','6,4','6,5','6,6','6,7','6,8','6,9','7,0']
		if grade.nil?
			return "-"
		else
			if grade >= 0 && grade <= 61
				scale[grade-1]
			else
				grade.to_s+'%'
			end
		end
	end
end