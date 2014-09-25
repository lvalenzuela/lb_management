class UserV < ActiveRecord::Base
	has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/assets/default_profile_pic.jpg"
	validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
	self.primary_key = 'id'
end
