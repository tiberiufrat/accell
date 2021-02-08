class Activity < ApplicationRecord
  belongs_to :subject, optional: true
  belongs_to :coordinator, class_name: "staff", foreign_key: "coordinator_id", optional: true
end
