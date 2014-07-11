module ClientsHelper

	def get_contact_name(contactid)
		c = Contact.find(contactid)
		return c.firstname+" "+c.lastname
	end

	def get_contact_institution(contactid)
		return Contact.find(contactid).institution

	end
end
