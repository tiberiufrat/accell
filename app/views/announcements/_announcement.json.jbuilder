json.extract! announcement, :id, :title, :text, :type, :sender_id, :created_at, :updated_at
json.url announcement_url(announcement, format: :json)
