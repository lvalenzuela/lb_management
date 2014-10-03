class MoodleGroup < ActiveRecord::Base
validates :groupname , uniqueness: true
end
