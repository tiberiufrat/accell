class CreateStaffs < ActiveRecord::Migration[6.1]
  def change
    create_table :staffs do |t|
      t.string :initial_password
      t.timestamps
    end
  end
end
