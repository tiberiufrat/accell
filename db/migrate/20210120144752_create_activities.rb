class CreateActivities < ActiveRecord::Migration[6.1]
  def change
    create_table :activities do |t|
      t.boolean :all_day, default: false
      t.datetime :start
      t.datetime :end
      t.string :days_of_week, array: true, default: []
      t.string :start_time
      t.string :end_time
      t.date :start_recur
      t.date :end_recur
      t.string :title
      t.string :description
      t.string :description_staff_only
      t.integer :creator_id
      t.references :coordinator, foreign_key: {to_table: :staffs}
      t.references :subject, foreign_key: {to_table: :subjects}

      t.timestamps
    end
  end
end
