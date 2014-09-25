class User < ActiveRecord::Base
	has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/assets/default_profile_pic.jpg"
	validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
	after_update :set_system_role

	def generate_token(column)
		begin
			self[column] = SecureRandom.urlsafe_base64
		end while User.exists?(column => self[column])
	end

	def check_auth_token
		if self.auth_token.nil?
			generate_token(:auth_token)
			self.system_role_id = 1000
			save!
		end
		return self.auth_token
	end

	def set_system_role
		user_role = RoleAssignation.where(:userid => self.id, :contextid => 1).first()

		if user_role.nil?
			self.system_role_id = 1000
		else
			self.system_role_id = user_role.roleid
		end
	end
end
