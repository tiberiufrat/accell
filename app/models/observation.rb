class Observation < ApplicationRecord
  belongs_to :creator, class_name: :User, foreign_key: :creator_id
  belongs_to :observationable, polymorphic: true
end
