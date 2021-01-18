class CreateSchools < ActiveRecord::Migration[6.1]
  def change
    create_table :schools do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :country
      t.string :city
      t.string :address
      t.string :registration_code

      t.timestamps
    end
  end
end
