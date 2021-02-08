class Staff < ApplicationRecord
	has_and_belongs_to_many :classrooms
	has_one :form, class_name: :Classroom, foreign_key: :form_tutor
	has_one :user, as: :profile, dependent: :destroy
	has_many :activities, foreign_key: "coordinator_id"
	accepts_nested_attributes_for :user, update_only: true

	def name
		user.name
	end
end
