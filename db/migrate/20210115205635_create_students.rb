class CreateStudents < ActiveRecord::Migration[6.1]
  def change
    create_table :students do |t|
      t.references :form, null: false, foreign_key: { to_table: :classrooms }
      t.references :family, null: false, foreign_key: { to_table: :families }
      t.string :initial_password
      t.date :entrance_date
      t.timestamps
    end
  end
end
