class Family < ApplicationRecord
	has_many :parents, dependent: :destroy
	has_many :students, dependent: :destroy
	belongs_to :main_parent, class_name: :Parent, foreign_key: :main_parent_id, optional: true
end
