class Mark < ApplicationRecord
  belongs_to :student
  belongs_to :activity
  belongs_to :staff

  has_one :subject, through: :activity
end
