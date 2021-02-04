class Student < ApplicationRecord
  belongs_to :form, class_name: :Classroom, foreign_key: :form_id, optional: true
  belongs_to :family
  has_one :user, as: :profile, dependent: :destroy
  has_one :form_tutor, through: :form
  has_and_belongs_to_many :classrooms
  has_many :observations, as: :observationable
  accepts_nested_attributes_for :user, update_only: true
  after_create :set_enrollment_date

  def set_enrollment_date
    self.update! enrollment_date: self.created_at if self.enrollment_date.nil?
  end

  def name 
    self.user.name
  end

  def name_and_form
    self.form ? self.name + ', ' + self.form.name : self.name + ', N/A'
  end
end
