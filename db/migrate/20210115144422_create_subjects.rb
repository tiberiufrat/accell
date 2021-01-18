class CreateSubjects < ActiveRecord::Migration[6.1]
  def change
    create_table :subjects do |t|
      t.string :title
      t.string :color
      t.string :icon
      t.boolean :staff_only, default: false
      t.boolean :individual_activity, default: false
      t.boolean :attendance, default: false
      t.integer :evaluation

      t.timestamps
    end
  end
end
