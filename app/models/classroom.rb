class Classroom < ApplicationRecord
  belongs_to :form_tutor, class_name: :Staff, foreign_key: :form_tutor_id, optional: true
  belongs_to :school
  has_many :form_students, class_name: :Student, foreign_key: :form
  has_and_belongs_to_many :staffs
  has_and_belongs_to_many :students
  after_create :generate_registration_code

  def generate_registration_code
    self.update! registration_code: Passgen.generate
  end

end