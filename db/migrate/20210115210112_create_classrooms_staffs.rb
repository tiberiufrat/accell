class CreateClassroomsStaffs < ActiveRecord::Migration[6.1]
  def change
    create_table :classrooms_staffs, id: false do |t|
      t.belongs_to :classroom
      t.belongs_to :staff
    end
  end
end
