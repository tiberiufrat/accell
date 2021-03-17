json.extract! staff, :id, :created_at, :updated_at

json.user_id staff.user.id
json.first_name staff.user.first_name
json.last_name staff.user.last_name
json.name staff.user.name
json.email staff.user.email
json.phone staff.user.phone
json.gender staff.user.api_gender_string
json.address staff.user.address
json.birth_date staff.user.birth_date.iso8601
json.locale staff.user.locale

json.current_school staff.current_school
json.schools staff.schools

json.form staff.form, partial: "api/v1/classrooms/classroom", as: :classroom

json.classrooms staff.classrooms, partial: "api/v1/classrooms/classroom", as: :classroom

json.url staff_url(staff, format: :json)