class AddPropertiesToFamily < ActiveRecord::Migration[6.1]
  def change
  	add_reference :families, :main_parent, references: :parents, foreign_key: { to_table: :parents }
  end
end
