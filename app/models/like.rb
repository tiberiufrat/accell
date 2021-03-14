class Like < ApplicationRecord
  belongs_to :likeable, polymorphic: true
  belongs_to :user

  def likeable_gid
    likeable&.to_global_id
  end
  
  def likeable_gid=(gid)
    self.likeable = GlobalID::Locator.locate gid
  end  
end
