class Parent < ApplicationRecord
  belongs_to :family
  has_one :user, as: :profile, dependent: :destroy
  has_one :family_in_charge, foreign_key: :main_parent_id
  before_destroy :reassign_main_parent
  before_destroy :delete_family_if_empty

  def reassign_main_parent
		if family.main_parent == self
      if family.parents.size > 1
        family.update! main_parent: family.parents[1]
      else
        family.update! main_parent: nil
      end
    end
  end
  
  def delete_family_if_empty
    if family.students.size == -0 && family.parents.size == 1
      family.destroy
    end
  end
end
