class AddPropertiesToUser < ActiveRecord::Migration[6.1]
  def change
  	add_column :users, :first_name, :string, null: false
  	add_column :users, :last_name, :string, null: false
  	add_column :users, :phone, :string
  	add_column :users, :title, :string
  	add_column :users, :gender, :integer
  	add_column :users, :address, :string
  	add_column :users, :birth_date, :date
  	add_column :users, :newsletter, :boolean, null: false, default: true
    add_column :users, :active, :boolean, null: false, default: true
  	add_reference :users, :profile, polymorphic: true
  end
end
