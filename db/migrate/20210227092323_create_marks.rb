class CreateMarks < ActiveRecord::Migration[6.1]
  def change
    create_table :marks do |t|
      t.belongs_to :student, null: false, foreign_key: { to_table: :students }
      t.belongs_to :activity, null: false, foreign_key: { to_table: :activities }
      t.string :grade, null: false
      t.date :date, null: false
      t.references :staff, null: false, foreign_key: { to_table: :staffs }
      t.boolean :quarter_weight, default: false

      t.timestamps
    end
  end
end
