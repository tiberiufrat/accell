class School < ApplicationRecord
	has_many :classrooms
	has_many :activities, as: :activityable

	has_many :students

	has_many :current_staffs, class_name: :Staff, foreign_key: :current_school

	has_and_belongs_to_many :staffs
end
