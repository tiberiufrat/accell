json.extract! classroom, :id, :name, :optional, :color, :form_tutor_id, :allow_registration, :registration_code, :school_id, :archived, :created_at, :updated_at

json.hex_color classroom.hex_color

json.url classroom_url(classroom, format: :json)