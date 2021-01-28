# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_01_25_051926) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "activities", force: :cascade do |t|
    t.boolean "all_day", default: false
    t.datetime "start"
    t.datetime "end"
    t.string "days_of_week", default: [], array: true
    t.string "start_time"
    t.string "end_time"
    t.date "start_recur"
    t.date "end_recur"
    t.string "title"
    t.string "description"
    t.string "description_staff_only"
    t.integer "creator_id"
    t.integer "coordinator_id"
    t.bigint "subject_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["subject_id"], name: "index_activities_on_subject_id"
  end

  create_table "classrooms", force: :cascade do |t|
    t.string "name"
    t.boolean "optional"
    t.string "color"
    t.bigint "form_tutor_id"
    t.boolean "allow_registration"
    t.string "registration_code"
    t.bigint "school_id", null: false
    t.boolean "archived", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["form_tutor_id"], name: "index_classrooms_on_form_tutor_id"
    t.index ["school_id"], name: "index_classrooms_on_school_id"
  end

  create_table "classrooms_staffs", id: false, force: :cascade do |t|
    t.bigint "classroom_id"
    t.bigint "staff_id"
    t.index ["classroom_id"], name: "index_classrooms_staffs_on_classroom_id"
    t.index ["staff_id"], name: "index_classrooms_staffs_on_staff_id"
  end

  create_table "classrooms_students", force: :cascade do |t|
    t.bigint "classroom_id"
    t.bigint "student_id"
    t.index ["classroom_id"], name: "index_classrooms_students_on_classroom_id"
    t.index ["student_id"], name: "index_classrooms_students_on_student_id"
  end

  create_table "families", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "main_parent_id"
    t.index ["main_parent_id"], name: "index_families_on_main_parent_id"
  end

  create_table "observations", force: :cascade do |t|
    t.string "text"
    t.bigint "creator_id"
    t.string "observationable_type"
    t.bigint "observationable_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["creator_id"], name: "index_observations_on_creator_id"
    t.index ["observationable_type", "observationable_id"], name: "index_observations_on_observationable"
  end

  create_table "parents", force: :cascade do |t|
    t.string "quality"
    t.bigint "family_id", null: false
    t.string "initial_password"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["family_id"], name: "index_parents_on_family_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource"
  end

  create_table "schools", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "phone"
    t.string "country"
    t.string "city"
    t.string "address"
    t.string "registration_code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "staffs", force: :cascade do |t|
    t.string "initial_password"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "students", force: :cascade do |t|
    t.bigint "form_id"
    t.bigint "family_id", null: false
    t.string "initial_password"
    t.date "enrollment_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["family_id"], name: "index_students_on_family_id"
    t.index ["form_id"], name: "index_students_on_form_id"
  end

  create_table "subjects", force: :cascade do |t|
    t.string "title"
    t.string "color"
    t.string "icon"
    t.boolean "staff_only", default: false
    t.boolean "individual_activity", default: false
    t.boolean "attendance", default: false
    t.integer "evaluation"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "phone"
    t.string "title"
    t.integer "gender"
    t.string "address"
    t.date "birth_date"
    t.boolean "newsletter", default: true, null: false
    t.boolean "active", default: true, null: false
    t.string "profile_type"
    t.bigint "profile_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["profile_type", "profile_id"], name: "index_users_on_profile"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "activities", "subjects"
  add_foreign_key "classrooms", "schools"
  add_foreign_key "classrooms", "staffs", column: "form_tutor_id"
  add_foreign_key "families", "parents", column: "main_parent_id"
  add_foreign_key "observations", "users", column: "creator_id"
  add_foreign_key "parents", "families"
  add_foreign_key "students", "classrooms", column: "form_id"
  add_foreign_key "students", "families"
end
