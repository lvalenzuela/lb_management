class RequestTag < ActiveRecord::Base
	validates :tagname, uniqueness: true, presence: true 
end
