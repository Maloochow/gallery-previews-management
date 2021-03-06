class User < ApplicationRecord
    belongs_to :gallery, optional: true
    has_many :client_invites
    has_many :clients, through: :client_invites
    has_many :user_invites
    has_secure_password
    has_one_attached :photo

    validates :email, presence: true, uniqueness: {case_sensitive: false}


    scope :gallery_users, -> (id) { where(gallery_id: id)}
    scope :search, -> (name) { where("username LIKE ?", "%#{name}%")}

    def self.find_or_create_from_omniauth(user_info)
        User.find_or_create_by(email: user_info["email"]) do |user|
            user.username = user_info["name"]
            user.password = SecureRandom.hex
        end
    end

    def invites
        UserInvite.where(new_user_email: self.email)
    end

    def gallery_clients
        invites = self.client_invites.where(gallery: self.gallery)
        invites.map {|invite| invite.client }
    end
end
