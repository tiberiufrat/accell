class AddSchoolsStaffs < ActiveRecord::Migration[6.1]
  def change
    create_table :schools_staffs, id: false do |t|
      t.belongs_to :school
      t.belongs_to :staff
    end
  end
end
