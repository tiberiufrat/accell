json.extract! activity, :id, :all_day, :start, :end, :days_of_week, :start_time, :end_time, :start_recur, :end_recur, :title, :description, :description_staff_only, :creator_id, :coordinator_id, :subject_id, :created_at, :updated_at
json.url activity_url(activity, format: :json)
