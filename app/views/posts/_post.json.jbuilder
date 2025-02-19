json.extract! post, :id, :name, :descriptions, :user_id, :created_at, :updated_at
json.url post_url(post, format: :json)
