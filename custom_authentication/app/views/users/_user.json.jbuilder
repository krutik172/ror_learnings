json.extract! user, :id, :username, :email, :password_digest, :remember_token, :created_at, :updated_at
json.url user_url(user, format: :json)
