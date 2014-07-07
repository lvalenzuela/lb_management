class Notification < ActiveRecord::Base
	before_create :unseen_notification

	def unseen_notification
		self.seen = 0
	end
end
