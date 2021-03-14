class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.text :body
      t.references :announcement, null: false, foreign_key: true
      t.integer :parent_id
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
