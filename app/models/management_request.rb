class ManagementRequest < ActiveRecord::Base
	validates :userid, :subject, :receiverarea, :priority, :status, :duedate, presence: true
end
