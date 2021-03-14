class AddAnnouncementsUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :announcements_users, id: false do |t|
      t.belongs_to :announcement
      t.belongs_to :user
    end
  end
end
