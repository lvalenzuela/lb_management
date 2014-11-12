class DetailedCourseReportPdf < Prawn::Document

	def initialize(course, institution, view_context)
		super(:margin => 50, :page_size => "TABLOID", :page_layout => :landscape)
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
			font "Helvetica", :size => 10
			general_data(institution, course.coursename)
			move_down 20
			grades_table(course, members)
		end	

		number_pages "<page> de <total>",:at => [1000, 0], size:10
	end

	def grades_table(course, members)
		course_g_data = StudentGradesReport.where(:courseid => course.moodleid, :hidden => 0, :created_at => Date.today)
		g_items = course_g_data.group(:itemid).order("sortorder ASC")
		g_categories = course_g_data.where("categoryname != '?' and itemname is null").select("distinct categoryid").order("sortorder ASC")

		#filas en que serán escritas las categorías
		category_rows = []
		c_counter = 0

		data = []
		table_headers = ["Evaluaciones"]
		members.each do |m|
			table_headers << m.lastname+", "+m.firstname
		end
		data << table_headers

		
		g_categories.each do |cat|
			category = nil
			g_items.where(:categoryid => cat.categoryid).each do |item|
				evaluation = []
				i_name = item.itemname
				if i_name
					#es un test
					evaluation << i_name
					members.each do |m|
						student_grade_data = course_g_data.where(:itemid => item.itemid, :userid => m.id)
						if student_grade_data.blank?
							evaluation << "-"
						else
							evaluation << grade_parser(student_grade_data.first().finalgrade, student_grade_data.first().gradetype)
						end
					end
					c_counter+= 1 #para saber en que fila se escriben las categorías
					data << evaluation
				else
					#es una categoría
					category = course_g_data.where(:itemid => item.itemid)
				end
			end
			#se escribe la categoría al final del resto de las evaluaciones
			cat_grade = []
			cat_grade << category.first().categoryname
			members.each do |m|
				student_cat_data = category.where(:userid => m.id)
				if student_cat_data.blank?
					cat_grade << "-"
				else
					cat_grade << grade_parser(student_cat_data.first().finalgrade, student_cat_data.first().gradetype)
				end
			end
			c_counter +=1
			category_rows << c_counter
			data << cat_grade
		end

		#promedio del curso
		course_grade = ["Promedio Curso"]
		members.each do |m|
			c_grade = course_g_data.where(:userid => m.id, :categoryname => '?', :itemname => nil)
			if c_grade.blank?
				course_grade << "-"
			else
				course_grade << grade_parser(c_grade.first().finalgrade, c_grade.first().gradetype)
			end
		end
		c_counter +=1 #corresponde a la fila en que se escribirá el promedio del curso
		#category_rows << c_counter
		data << course_grade

		table(data, :column_widths => {0 => 150}, 
			:cell_style => {:align => :center, :valign => :center,:size => 10, :borders => [:bottom], :border_width => 0.5, :inline_format => true, :padding => [5,5], :height => 40}, 
			:position => :center,
			:header => true) do
			cells.style do |c|
				if c.row == 0
					c.background_color = "F0F0F0"
				end
				if category_rows.include?(c.row)
					c.background_color = "F0F0F0"
					c.font_style = :bold
					c.size = 12
				end
				if c.row == c_counter
					c.font_style = :bold
					c.size = 12
				end
			end
		end
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

	def general_data(institution, group_name)

		font "Helvetica", :style => :bold
		text "Informe de Desempeño por Curso"
		font "Helvetica", :style => :normal

		data = [["<b>Curso</b>",group_name],
				["<b>Empresa</b>",institution],
				["<b>Fecha</b>", Date.today.strftime("%d-%m-%Y")]]
		table(data, :column_widths => {0 => 90, 1 => 350}, :cell_style => {:size => 10,:borders => [], :inline_format => true, :padding => [0,0]}, :position => :left)
	end

	private

	def grade_items(courseid)
		return StudentGradesReport.where(:courseid => courseid).group(:itemid).order("sortorder ASC").map{|i| i.itemid}
	end

	def course_members(courseid)
		#listado de alumnos
		students = StudentGradesReport.where(:courseid => courseid, :created_at => Date.today).group(:userid).map{|s| s.userid}
		return StudentV.where(:id => students)
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