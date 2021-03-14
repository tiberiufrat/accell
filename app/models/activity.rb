class Activity < ApplicationRecord
  belongs_to :subject, optional: true
  belongs_to :coordinator, class_name: "Staff", foreign_key: "coordinator_id", optional: true
  belongs_to :activityable, polymorphic: true, optional: true

  has_many :attendances, dependent: :destroy
	has_many :marks, dependent: :destroy

  has_many :students, through: :attendances

  scope :one_time, -> { where(:start_recur => nil) }
  scope :recurring, -> { where.not(:start_recur => nil) }

  def activityable_gid
    activityable&.to_global_id
  end
  
  def activityable_gid=(gid)
    self.activityable = GlobalID::Locator.locate gid
  end  

  def for_classroom?
    activityable_type == 'Classroom'
  end

  def for_student?
    activityable_type == 'Student'
  end

  def for_school?
    activityable_type == 'School'
  end
end
