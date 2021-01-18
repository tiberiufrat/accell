class Staff < ApplicationRecord
	has_and_belongs_to_many :classrooms
	has_one :form, class_name: :Classroom, as: :form_tutor
	has_one :user, as: :profile
	accepts_nested_attributes_for :user, update_only: true
end
