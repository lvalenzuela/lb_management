class Request < ActiveRecord::Base
	validates :userid, :statusid, :subject, :areaid, :priorityid, :statusid, :duedate, presence: true
end
