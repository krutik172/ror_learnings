class User < ApplicationRecord
    has_secure_password
    has_secure_token :remember_token
    validates :username, :email,  presence: true
    validates :username, :email, uniqueness:  true
    validates :password, confirmation: true, on: :create
    mount_uploader :avatar, AvatarUploader
    serialize :avatars, JSON
end
