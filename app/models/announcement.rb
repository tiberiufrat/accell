class Announcement < ApplicationRecord
  belongs_to :sender, class_name: 'Staff', foreign_key: 'sender_id'
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_and_belongs_to_many :users
  alias recipients users

  after_create :set_scheduled_for_if_empty

  def set_scheduled_for_if_empty
    if scheduled_for.nil?
      scheduled_for = DateTime.now
    end
  end
end
