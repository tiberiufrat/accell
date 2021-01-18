class Student < ApplicationRecord
  belongs_to :classroom
  belongs_to :family
  has_one :user, as: :profile
end
