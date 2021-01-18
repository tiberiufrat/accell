json.extract! subject, :id, :title, :color, :icon, :staff_only, :individual_activity, :attendance, :evaluation, :created_at, :updated_at
json.url subject_url(subject, format: :json)
