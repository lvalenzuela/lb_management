class DetailedStudentReportPdf < Prawn::Document
	def initialize(course, student, institution, view_context)
		super(:margin => 50)
		font "Helvetica"

		repeat :all do
			bounding_box [bounds.left, bounds.top + 30], :width  => bounds.width do
				header
			end

			bounding_box [bounds.left, bounds.bottom], :width  => bounds.width do
				footer
			end
		end

		bounding_box([bounds.left, bounds.top - 40], :width  => bounds.width, :height => bounds.height - 80) do
			font "Helvetica", :size => 10
			general_data(institution, course.coursename, student.name)
			move_down 20
			if course.sence_idnumber != "" && !course.sence_idnumber.blank?
				#asistencia sence
				course_attendance(course, student)
			else
				#asistencia no sence
				course_attendance_no_sence(course, student)
			end
			grades_table(course, student)
		end	

		number_pages "<page> de <total>",:at => [480, 0], size:10
	end

	def course_attendance(course, user)
		move_down 20
		font "Helvetica", :style => :bold, :size => 12
		text "1. Indicadores de Asistencia (SENCE)"
		font "Helvetica", :style => :normal, :size => 10
		move_down 10

		data = []
		data << ["Nombre", "RUT", "Presente", "Total Clases", "Tiempo Presente", "Tiempo a la Fecha", "Asistencia"]
		user_attendance_info = SenceAttendanceReport.where("course_id = #{course.moodleid} and user_idnumber = '#{user.idnumber}' and date(created_at) = curdate()").first()

		if user_attendance_info.blank?
			data << [user.lastname+" "+user.firstname, user.idnumber, "-", "-", "-", "-", "-"]
		else
			user_seconds = user_attendance_info.current_user_seconds % 60
			user_minutes = (user_attendance_info.current_user_seconds / 60) % 60
			user_hours = user_attendance_info.current_user_seconds / (60*60)
			course_seconds = user_attendance_info.current_course_seconds % 60
			course_minutes = (user_attendance_info.current_course_seconds / 60) % 60
			course_hours = user_attendance_info.current_course_seconds / (60*60)

			data << [user.lastname+", "+user.firstname, user.idnumber, user_attendance_info.p_sessions, user_attendance_info.current_sessions, format("%02d:%02d:%02d",user_hours,user_minutes,user_seconds), format("%02d:%02d:%02d",course_hours,course_minutes,course_seconds), (user_attendance_info.current_user_seconds.round(2)*100/user_attendance_info.current_course_seconds).round(2).to_s+"%"]
		end

		move_down 10
		data = [] #datos para la segunda tabla
		data << ["<b>Tiempo Presente</b>",format("%02d:%02d:%02d",user_hours,user_minutes,user_seconds)]
		data << ["<b>Tiempo Total</b>", format("%02d:%02d:%02d",course_hours,course_minutes,course_seconds)]
		data << ["<b>Asistencia SENCE</b>", "<b>"+(user_attendance_info.current_user_seconds.round(2)*100/user_attendance_info.current_course_seconds).round(2).to_s+"%</b>"]
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
	end

	def course_attendance_no_sence(course, user)
		move_down 20
		font "Helvetica", :style => :bold, :size => 12
		text "1. Indicadores de Asistencia"
		font "Helvetica", :style => :normal, :size => 10
		move_down 10

		report_data = UserReport.where(:userid => user.id, :courseid => course.moodleid).order("created_at DESC").first()

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
		data = [] #datos para la segunda tabla
		data << ["<b>Asistencias</b>",report_data.p_sessions.to_s]
		data << ["<b>Clases Totales</b>", report_data.current_sessions.to_s]
		data << ["<b>Porcentaje de Asistencia</b>", "<b>"+att_pct.to_s+"%</b>"]
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
	end

	def grades_table(course, student)

		move_down 20
		font "Helvetica", :style => :bold, :size => 12
		text "2. Indicadores de Academicos"
		font "Helvetica", :style => :normal, :size => 10
		move_down 10

		course_g_data = StudentGradesReport.where(:courseid => course.moodleid, :hidden => 0, :userid => student.id, :created_at => Date.today)
		g_items = course_g_data.group(:itemid).order("sortorder ASC")
		g_categories = course_g_data.where("categoryname != '?' and itemname is null").select("distinct categoryid").order("sortorder ASC")

		#filas en que serán escritas las categorías
		category_rows = []
		c_counter = 0

		data = []
		table_headers = ["Evaluaciones", "Nota"]
		data << table_headers

		
		g_categories.each do |cat|
			category = nil
			g_items.where(:categoryid => cat.categoryid).each do |item|
				evaluation = []
				i_name = item.itemname
				if i_name
					#es un test
					evaluation << i_name
					student_grade_data = course_g_data.find_by_itemid(item.itemid)
					if student_grade_data.blank?
						evaluation << "-"
					else
						evaluation << grade_parser(student_grade_data.finalgrade, student_grade_data.gradetype)
					end
					c_counter+= 1 #para saber en que fila se escriben las categorías
					data << evaluation
				else
					#es una categoría
					category = course_g_data.find_by_itemid(item.itemid)
				end
			end
			#se escribe la categoría al final del resto de las evaluaciones
			cat_grade = []
			cat_grade << category.categoryname
			if category.blank?
				cat_grade << "-"
			else
				cat_grade << grade_parser(category.finalgrade, category.gradetype)
			end
			c_counter +=1
			category_rows << c_counter
			data << cat_grade
		end

		#promedio del curso
		course_grade = ["Promedio Curso"]
		c_grade = course_g_data.where(:categoryname => '?', :itemname => nil)
		if c_grade.blank?
			course_grade << "-"
		else
			course_grade << grade_parser(c_grade.first().finalgrade, c_grade.first().gradetype)
		end

		c_counter +=1 #corresponde a la fila en que se escribirá el promedio del curso
		#category_rows << c_counter
		data << course_grade

		table(data, :column_widths => {0 => 300, 1 => 200}, 
			:cell_style => {:align => :center, :valign => :center,:size => 10, :border_width => 0.5, :inline_format => true, :padding => [5,5], :height => 40}, 
			:position => :center,
			:header => true) do
			cells.style do |c|
				if c.row == 0
					c.background_color = "F0F0F0"
					c.size = 12
					c.font_style = :bold
				end
				if category_rows.include?(c.row)
					c.background_color = "F0F0F0"
					#c.font_style = :bold
					c.size = 12
				end
				if c.row == c_counter
					c.font_style = :bold
					c.size = 12
				end
			end
		end
	end

	def general_data(institution, coursename, studentname)
		font "Helvetica", :style => :bold, :size => 12
		text "Informe de Desempeño por Curso"
		font "Helvetica", :style => :normal

		data = [["<b>Alumno</b>", studentname],
				["<b>Curso</b>",coursename],
				["<b>Empresa</b>",institution],
				["<b>Fecha</b>", Date.today.strftime("%d-%m-%Y")]]
		table(data, :column_widths => {0 => 90, 1 => 350}, :cell_style => {:size => 12,:borders => [], :inline_format => true, :padding => [2,0]}, :position => :left)
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

	private

	def grade_items(courseid)
		return StudentGradesReport.where(:courseid => courseid).group(:itemid).order("sortorder ASC").map{|i| i.itemid}
	end

	def grade_parser(grade, gradetype)
		case gradetype
		when 1
			if grade.nil?
				return "-"
			else
				return grade.round(1).to_s+"%"
			end
		when 2
			#transforma notas desde una escala de 0 a 61 a la escala chilena
			scale = ['1.0','1.1','1.2','1.3','1.4','1.5','1.6','1.7','1.8','1.9','2.0','2.1','2.2','2.3','2.4','2.5','2.6','2.7','2.8','2.9','3.0','3.1','3.2','3.3','3.4','3.5','3.6','3.7','3.8','3.9','4.0','4.1','4.2','4.3','4.4','4.5','4.6','4.7','4.8','4.9','5.0','5.1','5.2','5.3','5.4','5.5','5.6','5.7','5.8','5.9','6.0','6.1','6.2','6.3','6.4','6.5','6.6','6.7','6.8','6.9','7.0']
			if grade.nil?
				return "-"
			else
				grade = grade.round(0)
				return scale[grade-1]
			end
		else
			return gradetype
		end
	end
end