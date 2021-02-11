class School < ApplicationRecord
	has_many :classrooms
	has_many :activities, as: :activityable
end
