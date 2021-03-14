class CreateAnnouncements < ActiveRecord::Migration[6.1]
  def change
    create_table :announcements do |t|
      t.string      :title
      t.string      :text
      t.string      :category
      t.datetime    :scheduled_for, default: -> { 'NOW()' }
      t.boolean     :deleted, default: false, null: false      
      t.references  :sender, null: false, foreign_key: { to_table: :staffs }

      t.timestamps
    end
  end
end
