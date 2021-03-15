class Student < ApplicationRecord
  belongs_to :form, class_name: :Classroom, foreign_key: :form_id, optional: true
  belongs_to :family
  belongs_to :school
  
  has_one :user, as: :profile, dependent: :destroy
  has_one :form_tutor, through: :form

  has_many :observations, as: :observationable, dependent: :destroy
  has_many :activities, as: :activityable, dependent: :destroy
  has_many :attendances, dependent: :destroy
  has_many :marks, dependent: :destroy

  has_many :attended_activities, through: :attendances, source: :activity
  has_many :subjects, through: :attended_activities

  has_and_belongs_to_many :classrooms

  accepts_nested_attributes_for :user, update_only: true

  after_create :set_enrollment_date
  before_destroy :delete_family_if_empty

  scope :with_no_form, -> { where(form_id: nil) }

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

  def has_activity_own_or_inherited? activity
    [self, self.form, *self.classrooms].include? activity.activityable
  end

  def has_subject? subject
    self.activities.map(&:subject).include? subject if self.activities.any?
  end

  def marks_for_subject subject
    subject.activities.map(&:marks).flatten.uniq.select {|m| m.student == self}
  end

  def average_for_subject subject
    marks_for_subject = self.marks_for_subject subject

    if marks_for_subject.any?
      average = case subject.evaluation
        when 1, 4
          sum = marks_for_subject.inject(0) { |sum, mark| sum + mark.grade.to_f }
          avg = (sum / marks_for_subject.size).round
          subject.evaluation == 4 ? "#{avg}%" : avg
        when 3
          freq_hash = {'FB' => 0, 'B' => 0, 'S' => 0, 'I' => 0}
          marks_for_subject.each {|m| freq_hash[m.grade] += 1 }
          most_freq_val = freq_hash.sort_by {|_key, value| value}.reverse[0][0] 
          # byebug
        else
          'N/A'
        end
    else
      return 'N/A'
    end

  end

end
