module CoursesHelper

	def get_course_type(id)
		return CourseType.find(id).typename
	end

	def weekday_options
		return [["Lunes","Lunes"],
				["Martes","Martes"],
				["Miercoles","Miercoles"],
				["Jueves","Jueves"],
				["Viernes","Viernes"],
				["Sabado","Sabado"]]
	end
end
