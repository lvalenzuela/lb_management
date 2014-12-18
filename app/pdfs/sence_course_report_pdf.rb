class SenceCourseReportPdf < Prawn::Document

	def initialize(course, institution, date, view_context)
		super(:margin => 50)
		font "Helvetica"
		members = course_members(course.moodleid)

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
			general_data(institution, course.coursename, date)
			
			if course.sence_idnumber != "" && !course.sence_idnumber.blank?
				course_attendance(members, date)
			else
				course_attendance_no_sence(members, date)
			end
			indicadores_academicos(members, date)
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

	def general_data(institution, group_name, date)

		font "Helvetica", :style => :bold
		text "Informe de Desempeño por Curso"
		font "Helvetica", :style => :normal

		data = [["<b>Curso</b>",group_name],
				["<b>Empresa</b>",institution],
				["<b>Fecha</b>", date.strftime("%d-%m-%Y")]]
		table(data, :column_widths => {0 => 90, 1 => 350}, :cell_style => {:size => 12,:borders => [], :inline_format => true, :padding => [0,0]}, :position => :left)
	end

	def sence_attendance(members,date)
		move_down 20
		font "Helvetica", :style => :bold
		text "1. Indicadores de Asistencia"
		font "Helvetica", :style => :normal
		move_down 10

		data = []
		data << ["Nombre", "RUT", "Presente", "Total Clases", "Horas Presente", "Horas a la Fecha", "Asistencia"]
		members.each do |member|
			user = StudentV.find(member.userid)
			user_attendance_info = SenceAttendanceReport.where(:user_idnumber => user.idnumber, :created_at => date).first()
			data << [user.lastname+" "+user.firstname, user.idnumber, user_attendance_info.p_sessions, user_attendance_info.current_sessions, l(user_attendance_info.current_user_time, :format => "%H:%M"), l(user_attendance_info.current_course_time, :format => "%H:%M"), ""]
		end

		table(data, :column_widths => {0 => 100, 1 => 80, 2 => 81, 3 => 81, 4 => 81, 5 => 82, 6 => 81}, 
					:cell_style => {:align => :center, :valign => :center,:size => 8, :border_width => 0.5, :inline_format => true, :padding => [5,5]}, 
					:position => :center,
					:header => true) do
			cells.style do |c|
				if c.row == 0
					c.background_color = "F0F0F0"
					c.font_style = :bold
				end
			end
		end
		move_down 10
	end


	def course_attendance_no_sence(members,date)
		move_down 20
		font "Helvetica", :style => :bold
		text "1. Indicadores de Asistencia"
		font "Helvetica", :style => :normal
		move_down 10

		data = []
		data << ["<b>Nombre</b>", "<b>RUT</b>", "<b>Presente</b>", "<b>Ausente / Tarde</b>", "<b>Clases Realizadas</b>", "<b>Asistencia<b>"]	#encabezado de la tabla		
		members.each do |member|
			user = StudentV.find(member.userid)
			if date
				member_data = UserReport.where(:userid => member.userid, :courseid => member.courseid, :created_at => date).first()
			else
				member_data = UserReport.where(:userid => member.userid, :courseid => member.courseid).order("created_at DESC").first()
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

			data << [user.lastname+", "+user.firstname, user.idnumber, member_data.p_sessions.to_s, a_sessions.to_s, member_data.current_sessions.to_s+" de "+member_data.total_sessions.to_s, "<b>"+att_pct.to_s+"%</b>"]
		end

		table(data, :column_widths => {0 => 100, 1 => 80, 2 => 81, 3 => 81, 4 => 81, 5 => 82, 6 => 81}, 
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
	end

	def course_attendance(members,date)
		move_down 20
		font "Helvetica", :style => :bold
		text "1. Indicadores de Asistencia"
		font "Helvetica", :style => :normal
		move_down 10
		

		data = []
		data << ["<b>Nombre</b>", "<b>RUT</b>", "<b>Presente</b>", "<b>Ausente / Tarde</b>", "<b>F.S.(*)</b>", "<b>Clases Realizadas</b>", "<b>Asistencia<b>"]	#encabezado de la tabla		
		members.each do |member|
			user = StudentV.find(member.userid)
			if date
				member_data = UserReport.where(:userid => member.userid, :courseid => member.courseid, :created_at => date).first()
			else
				member_data = UserReport.where(:userid => member.userid, :courseid => member.courseid).order("created_at DESC").first()
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
			data << [user.lastname+", "+user.firstname, user.idnumber, member_data.p_sessions.to_s, a_sessions.to_s, sence.to_s, member_data.current_sessions.to_s+" de "+member_data.total_sessions.to_s, "<b>"+att_pct.to_s+"%</b>"]
		end

		table(data, :column_widths => {0 => 100, 1 => 80, 2 => 65, 3 => 65, 4 => 65, 5 => 65, 6 => 65}, 
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

	def indicadores_academicos(members, date)
		move_down 15
		font "Helvetica", :style => :bold
		text "2. Indicadores Academicos"
		font "Helvetica", :style => :normal
		move_down 10

		data = []
		data << ["<b>Nombre</b>", "<b>RUT</b>","<b>Homework</b>","<b>Tests T.E.G</b>","<b>Tests</b>","<b>Oral Test</b>","<b>Promedio</b>"]
		members.each do |member|
			user = StudentV.find(member.userid)
			if date
				member_data = UserReport.where(:userid => member.userid, :courseid => member.courseid, :created_at => date).first()
			else
				member_data = UserReport.where(:userid => member.userid, :courseid => member.courseid).order("created_at DESC").first()
			end
			data << [user.lastname+", "+user.firstname, user.idnumber, grade_parser(member_data.grade_homework), grade_parser(member_data.grade_tests_teg), grade_parser(member_data.grade_tests), grade_parser(member_data.grade_oral_tests), "<b>"+grade_parser(member_data.grade_course)+"</b>"]
		end
		table(data, :column_widths => {0 => 100, 1 => 80, 2 => 65, 3 => 65, 4 => 65, 5 => 65, 6 => 65}, 
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

	def course_members(courseid)
		return UserReport.where("courseid = #{courseid} 
			and created_at = '#{last_report_date.to_s}'").select("courseid,
															coursename,
															userid,
															firstname,
															lastname,
															institution,
															department").group("userid")
	end

	def last_report_date
		return UserReport.all().order("created_at DESC").first().created_at
	end

	def grade_parser(grade)
		#transforma notas desde una escala de 0 a 61 a la escala chilena
		scale = ['1.0','1.1','1.2','1.3','1.4','1.5','1.6','1.7','1.8','1.9','2.0','2.1','2.2','2.3','2.4','2.5','2.6','2.7','2.8','2.9','3.0','3.1','3.2','3.3','3.4','3.5','3.6','3.7','3.8','3.9','4.0','4.1','4.2','4.3','4.4','4.5','4.6','4.7','4.8','4.9','5.0','5.1','5.2','5.3','5.4','5.5','5.6','5.7','5.8','5.9','6.0','6.1','6.2','6.3','6.4','6.5','6.6','6.7','6.8','6.9','7.0']
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