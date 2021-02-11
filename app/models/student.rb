class Student < ApplicationRecord
  belongs_to :form, class_name: :Classroom, foreign_key: :form_id, optional: true
  belongs_to :family
  
  has_one :user, as: :profile, dependent: :destroy
  has_one :form_tutor, through: :form

  has_many :observations, as: :observationable
  has_many :activities, as: :activityable

  has_and_belongs_to_many :classrooms

  accepts_nested_attributes_for :user, update_only: true

  after_create :set_enrollment_date
  before_destroy :delete_family_if_empty

  def set_enrollment_date
    self.update! enrollment_date: self.created_at if self.enrollment_date.nil?
  end

  def name 
    self.user.name
  end

  def name_and_form
    self.form ? self.name + ', ' + self.form.name : self.name + ', N/A'
  end

  def delete_family_if_empty
    if family.students.size == 1 && family.parents.size == 0
      family.destroy
    end
  end
end
