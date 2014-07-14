class QuotationPdf < Prawn::Document
	
	def initialize(quotation, view_context)
		super(:margin => 50)
		font "Helvetica"
		repeat :all do
			bounding_box [bounds.left, bounds.top + 30], :width  => bounds.width do
				header
			end

			bounding_box [bounds.left, bounds.top + 20], :width => bounds.width do
				quotation_info(quotation)
			end

			bounding_box [bounds.left, bounds.bottom], :width  => bounds.width do
				footer
			end
		end

		bounding_box([bounds.left, bounds.top - 40], :width  => bounds.width, :height => bounds.height - 70) do
			font "Helvetica", :size => 11
			client_data(quotation)
			move_down 20
			quotation_body(quotation)
			move_down 20
			quotation_products(quotation)
			move_down 20
			quotation_comments(quotation)
			move_down 20
			quotation_footer(quotation)
		end
		number_pages "<page> de <total>",:at => [480, 0], size:9
	end

	def quotation_products(q)
		products = Product.joins("inner join quotation_products as qp
										on products.id = qp.productid
										and qp.quotationid = #{q.id}
										inner join product_prices as pp
										on products.productpriceid = pp.id").select("products.id as productid,
																					 products.students_qty as students_qty,
																					 products.location as location,
																					 pp.modality as modality,
																					 pp.students_qty as max_students,
																					 pp.hours_amt as hours_amt,
																					 pp.price as price")
		data = []
		data << ["<b>Modalidad</b>", "<b>Ubicacion</b>", "<b>Cantidad Alumnos</b>", "<b>Precio / Alumno</b>", "<b>Horas Curso</b>", "<b>Total</b>"]
		products.each do |p|
			data << [p.modality, p.location, p.students_qty, ActionController::Base.helpers.number_to_currency((p.price/p.students_qty), :unit => "$", :precision => 0), p.hours_amt.to_s, ActionController::Base.helpers.number_to_currency(p.price, :unit => "$", :precision => 0)]
		end

		table(data, :column_widths => {0 => 83, 1 => 83, 2 => 83, 3 => 83, 4 => 83, 5 => 83},
			:cell_style => {:align => :center,:size => 10, :border_width => 0.2, :inline_format => true, :padding => [5,5]}, 
			:position => :center) do
			cells.style do |c|
				if c.row == 0
					c.background_color = "F0F0F0"
				end
				if c.column == 5
					c.background_color = "F0F0F0"
				end
			end
		end

		if !q.discount.nil? && q.discount != 0
			discountdata = [["<b>Descuento</b>", (q.discount*100).to_s+"%"],
							["<b>Total Programa</b>", "<b>"+ActionController::Base.helpers.number_to_currency(q.price, :unit => "$", :precision => 0)+"</b>"]]
			table(discountdata, :column_widths => {0 => 415, 1 => 83 },
				:cell_style => {:align => :center,:size => 10, :border_width => 0.2, :inline_format => true, :padding => [5,5]}, 
				:position => :center) do
				cells.style do |c|
					if c.column == 1
						c.background_color = "F0F0F0"
					end
				end
			end
		end
	end

	def quotation_body(q)
		client = Contact.find(q.contactid)
		text "Estimado(a) <b>"+client.firstname+"</b>:", :inline_format => true
		text "Tenemos el agrado de hacer entrega de esta cotización de Cursos de Inglés en Longbourn Institute."
		text "Nuestros cursos tienen las siguientes características:"
		data = [["","•","Se dictan cursos en niveles básico, intermedio y experto. La asignación de grupos se llevará a cabo una ves que se aplique nuestra Prueba de Diagnostico a los interesados."],
				["","•","Longbourn Institute se diferencia por generar cursos de inglés adaptados a las necesidades de cada empresa, por lo cual los temas tratados serían temas de importancia para <b>"+client.institution+"</b>"],
				["","•","Contamos con código SENCE."]]
		table(data,:column_widths => {0 => 30,1 => 33, 2 => 437 },
				:cell_style => {:align => :left,:size => 11, :borders => [], :inline_format => true, :padding => [5,5]}, 
				:position => :center)
	end

	def quotation_comments(q)
		data = [["<b>Observaciones</b>", q.comments]]
		table(data, :column_widths => {0 => 83, 1 => 417 },
			:cell_style => {:align => :left,:size => 10, :border_width => 0.2, :inline_format => true, :padding => [5,5]}, 
			:position => :center) do
			cells.style do |c|
				if c.row == 0 && c.column == 0
					c.background_color = "F0F0F0"
				end
			end
		end
		
	end

	def quotation_footer(q)
		text "Los precios son exentos de IVA e incluyen clases precenciales, libros y material docente. Además se brindará acceso a los usuarios al sitio web de estudiantes de Longbourn Institute."
		move_down 10
		text "Formas de pago:"
		data = [["","•","<b>Para Empresas:</b> Orden de compra y pago a 30 días."]]
		table(data,:column_widths => {0 => 30,1 => 33, 2 => 437 },
				:cell_style => {:align => :left,:size => 11, :borders => [], :inline_format => true, :padding => [5,5]}, 
				:position => :center)
		move_down 10
		text "Para continuar con el proceso de matrícula, se debe coordinar nuestra <b>Prueba de Diagnóstico</b> para los interesados. Con estos resultados podremos armar los grupos de trabajo y asignar los niveles de los cursos correspondientes.", :inline_format => true
		text "Estamos atentos a su confirmación.", :inline_format => true
	end

	def quotation_info(q)
		#información sobre el número de cotizacion y la fecha
		font "Helvetica", :style => :bold
		text "Cotizacion "+q.id.to_s, :align => :center, :size => 12
		move_down 10
		text "Santiago, "+Date.current().strftime("%d-%m-%Y"), :align => :right, :size => 10
	end

	def client_data(q)
		client = Contact.find(q.contactid)
		provider = Contact.where(:typeid => 1).first()
		user = User.find(q.userid)

		bounding_box [bounds.left, bounds.top], :width => 245 do
			#Tabla del Proveedor
			providerdata = [["<b>Proveedor</b>", provider.institution],
							["<b>Rut</b>", provider.rut],
							["<b>Dirección</b>", provider.address],
							["<b>Telefono</b>", provider.phone],
							["<b>Atención</b>", user.firstname+" "+user.lastname],
							["<b>E-Mail</b>", user.email]]
			table(providerdata, :column_widths => {0 => 70, 1 => 175}, :cell_style => {:size => 10,:borders => [], :inline_format => true, :padding => [1,0]}, :position => :left)
		end

		bounding_box [bounds.left + 255, bounds.top], :width => 245 do
			#Tabla de cliente
			clientdata = [["<b>Comprador</b>", client.institution],
							["<b>Rut</b>", client.rut],
							["<b>Dirección</b>", client.address],
							["<b>Telefono</b>", client.phone],
							["<b>Atención</b>", client.firstname+" "+user.lastname],
							["<b>E-Mail</b>", client.email]]
			table(clientdata, :column_widths => {0 => 70, 1 => 175}, :cell_style => {:size => 10,:borders => [], :inline_format => true, :padding => [1,0]}, :position => :left)
		end
	end

	def header
		logo_path = Rails.root.join('app','assets','images','longbourn_logo.png')
		image logo_path, :width => 70, :height => 45
	end

	def footer
		move_cursor_to 30
		font "Helvetica", :size => 9
		text "Badajoz 130 Oficina 405, esquina Alonso de Córdova, Las Condes", :align => :center
		text "Fono:(56-2)2951 1482 - Correo: contacto@longbourn.cl", :align => :center
		text "www.longbourn.cl", :align => :center
	end
end