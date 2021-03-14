class CreateStaffs < ActiveRecord::Migration[6.1]
  def change
    create_table :staffs do |t|
      t.string :initial_password
      t.references :current_school, null: false, foreign_key: { to_table: :schools }
      t.timestamps
    end
  end
end
