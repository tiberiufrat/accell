class CreateParents < ActiveRecord::Migration[6.1]
  def change
    create_table :parents do |t|
      t.string :quality
      t.references :family, null: false, foreign_key: { to_table: :families }
      t.string :initial_password
      t.timestamps
    end
  end
end
