json.extract! student, :id, :form_id, :family_id, :school_id, :created_at, :updated_at

json.user_id student.user.id
json.first_name student.user.first_name
json.last_name student.user.last_name
json.name student.user.name
json.email student.user.email
json.phone student.user.phone
json.gender student.user.api_gender_string
json.address student.user.address
json.birth_date student.user.birth_date.iso8601 if student.birth_date
json.locale student.user.locale

json.form_name (student.form ? student.form.name : nil)
json.form_color (student.form ? student.form.hex_color : nil)

json.enrollment_date student.enrollment_date.iso8601
json.form_tutor_id (student.form && student.form.form_tutor ? student.form.form_tutor.name : nil)

# json.teachers student.form.staffs, partial: "api/v1/staffs/staff", as: :staff

json.optional_classrooms student.classrooms, partial: "api/v1/classrooms/classroom", as: :classroom

json.url student_url(student, format: :json)