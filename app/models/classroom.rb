class Classroom < ApplicationRecord
  belongs_to :form_tutor, class_name: :Staff, foreign_key: :form_tutor_id
  belongs_to :school
  has_many :students
  has_and_belongs_to_many :staffs
end
