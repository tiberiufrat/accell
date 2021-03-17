class Staff < ApplicationRecord
	belongs_to :current_school, class_name: :School, foreign_key: :current_school_id

	has_and_belongs_to_many :classrooms
	has_and_belongs_to_many :schools
	
	has_one :form, class_name: :Classroom, foreign_key: :form_tutor
	has_one :user, as: :profile, dependent: :destroy

	has_many :activities, foreign_key: "coordinator_id", dependent: :destroy
	has_many :announcements, foreign_key: "sender_id", dependent: :destroy
	has_many :marks, dependent: :destroy

	accepts_nested_attributes_for :user, update_only: true

	def self.has_school school
		Staff.all.filter {|s| s.schools.include? school}
	end

	def name
		user.name
	end
end
