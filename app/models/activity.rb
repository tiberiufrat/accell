class Activity < ApplicationRecord
  belongs_to :subject, optional: true
  belongs_to :coordinator, class_name: "Staff", foreign_key: "coordinator_id", optional: true
  belongs_to :activityable, polymorphic: true, optional: true

  def activityable_gid
    activityable&.to_global_id
  end
  
  def activityable_gid=(gid)
    self.activityable = GlobalID::Locator.locate gid
  end  
end
