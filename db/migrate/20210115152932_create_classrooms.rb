class CreateClassrooms < ActiveRecord::Migration[6.1]
  def change
    create_table :classrooms do |t|
      t.string :name
      t.boolean :optional
      t.string :color
      t.references :form_tutor, references: :staffs, foreign_key: { to_table: :staffs }
      t.boolean :allow_registration
      t.string :registration_code
      t.references :school, null: false, foreign_key: { to_table: :schools }
      t.boolean :archived, null: false, default: false

      t.timestamps
    end
  end
end
