class CreateAttendances < ActiveRecord::Migration[6.1]
  def change
    create_table :attendances do |t|
      t.belongs_to :student, null: false, foreign_key: true
      t.belongs_to :activity, null: false, foreign_key: true
      t.string :presence
      t.date :date

      t.timestamps
    end
  end
end
