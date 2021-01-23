class Student < ApplicationRecord
  belongs_to :form, class_name: :Classroom, foreign_key: :form_id
  belongs_to :family
  has_one :user, as: :profile
  has_and_belongs_to_many :classrooms
  accepts_nested_attributes_for :user, update_only: true
end
