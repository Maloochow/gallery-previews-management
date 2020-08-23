class User < ApplicationRecord
    belongs_to :gallery
    has_many :client_invites
    has_secure_password
    validates :email, presence: true, uniqueness: {case_sensitive: false}

    def self.find_or_create_from_omniauth(user_info)
        User.find_or_create_by(email: user_info["email"]) do |user|
            user.username = user_info["name"]
            user.password = SecureRandom.hex
        end
    end
end
