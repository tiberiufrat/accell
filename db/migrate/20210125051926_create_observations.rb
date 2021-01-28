class CreateObservations < ActiveRecord::Migration[6.1]
  def change
    create_table :observations do |t|
      t.string :text
      t.references :creator, references: :users, foreign_key: { to_table: :users }
      t.references :observationable, polymorphic: true

      t.timestamps
    end
  end
end
