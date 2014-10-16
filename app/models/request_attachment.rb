class RequestAttachment < ActiveRecord::Base
	has_attached_file :attached_file
end
