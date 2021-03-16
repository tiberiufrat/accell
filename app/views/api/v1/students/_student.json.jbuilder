json.extract! student, :id, :form_id, :family_id, :school_id, :created_at, :updated_at

json.user_id student.user.id
json.first_name student.user.first_name
json.last_name student.user.last_name
json.name student.user.name
json.email student.user.email
json.phone student.user.phone
json.gender student.user.api_gender_string
json.address student.user.address
json.birth_date student.user.birth_date.iso8601
json.locale student.user.locale

json.url student_url(student, format: :json)