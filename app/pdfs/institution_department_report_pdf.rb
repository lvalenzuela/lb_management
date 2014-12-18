class InstitutionDepartmentReportPdf < Prawn::Document
	
	def initialize(institution, department, reportdate, view_context)
		super(:margin => 50)
		font "Helvetica"
		members = find_group_members(institution, department)
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
			general_data(institution, department, reportdate)
			course_attendance(members, institution, department, reportdate)
			indicadores_academicos(members, institution, department, reportdate)
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
		text "Coronel Pereira 72 Piso 11, Las Condes", :align => :center
		text "Fono:(56 2) 2378 7720 - Correo: contacto@longbourn.cl", :align => :center
		text "www.longbourn.cl", :align => :center
	end

	def general_data(institution, department, reportdate)
		font "Helvetica", :style => :bold
		text "Informe de Desempeño por Curso"
		font "Helvetica", :style => :normal
		if reportdate.nil?
			date = Date.today()
		else
			date = reportdate
		end
		data = [["<b>Empresa</b>", institution],
				["<b>Departamento</b>", department],
				["<b>Fecha</b>", date]]
		table(data, :column_widths => {0 => 90, 1 => 350}, :cell_style => {:size => 12,:borders => [], :inline_format => true, :padding => [0,0]}, :position => :left)
	end

	def course_attendance(members, institution, department, reportdate)
		move_down 20
		font "Helvetica", :style => :bold
		text "1. Indicadores de Asistencia"
		font "Helvetica", :style => :normal
		move_down 10

		data = []
		data << ["<b>Nombre</b>", "<b>RUT</b>", "<b>Curso</b>", "<b>Presente</b>", "<b>Ausente / Tarde</b>", "<b>F.S.(*)</b>", "<b>Clases Realizadas</b>", "<b>Asistencia<b>"]	#encabezado de la tabla		
		members.each do |member|
			user = StudentV.find(member.userid)
			if reportdate.nil?
				member_data = CourseGroupReport.where(:userid => member.userid, :institution => institution, :department => department).order("created_at DESC").first()
			else
				member_data = CourseGroupReport.where(:userid => member.userid, :institution => institution, :department => department, :created_at => reportdate).first()
			end
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

			data << [user.lastname+", "+user.firstname, user.idnumber, get_groupname(member_data.groupid), member_data.p_sessions.to_s, a_sessions.to_s, sence.to_s, member_data.current_sessions.to_s+" de "+member_data.total_sessions.to_s, "<b>"+att_pct.to_s+"%</b>"]
		end

		table(data, :column_widths => {0 => 100, 1 => 80, 2 => 54, 3 => 54, 4 => 54, 5 => 54, 6 => 54, 7 => 54}, 
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

	def indicadores_academicos(members, institution, department, reportdate)
		move_down 15
		font "Helvetica", :style => :bold
		text "2. Indicadores Academicos"
		font "Helvetica", :style => :normal
		move_down 10

		data = []
		data << ["<b>Nombre</b>", "<b>RUT</b>", "<b>Curso</b>","<b>Homework</b>","<b>Tests T.E.G</b>","<b>Tests</b>","<b>Oral Test</b>","<b>Promedio</b>"]
		members.each do |member|
			user = StudentV.find(member.userid)
			if reportdate.nil?
				member_data = CourseGroupReport.where(:userid => member.userid, :institution => institution, :department => department).order("created_at DESC").first()
			else
				member_data = CourseGroupReport.where(:userid => member.userid, :institution => institution, :department => department, :created_at => reportdate).first()
			end

			data << [user.lastname+", "+user.firstname, user.idnumber, get_groupname(member_data.groupid), grade_parser(member_data.grade_homework), grade_parser(member_data.grade_tests_teg), grade_parser(member_data.grade_tests), grade_parser(member_data.grade_oral_tests), "<b>"+grade_parser(member_data.grade_coursegroup)+"</b>"]
		end
		table(data, :column_widths => {0 => 100, 1 => 80, 2 => 54, 3 => 54, 4 => 54, 5 => 54, 6 => 54, 7 => 54}, 
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

	def get_groupname(id)
		MoodleGroup.find(id).groupname
	end

	def find_group_members(institution, department)
		return members = CourseGroupReport.where(:institution => institution, :department => department).select("distinct(userid) as userid")
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