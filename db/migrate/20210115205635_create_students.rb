class CreateStudents < ActiveRecord::Migration[6.1]
  def change
    create_table :students do |t|
      t.references :form, foreign_key: { to_table: :classrooms }
      t.references :family, null: false, foreign_key: { to_table: :families }
      t.references :school, null: false, foreign_key: { to_table: :schools }
      t.string :initial_password
      t.date :enrollment_date
      t.timestamps
    end
  end
end
