class Gallery < ApplicationRecord
    has_many :users
    has_many :user_invites, through: :users
    has_many :client_invites
    has_many :clients, through: :client_invites
    has_many :artworks
    validates :name, presence: true, uniqueness: true

    def admin_name
        self.admin.username
    end

    def admin
        User.find_by_id(self.admin_user_id)
    end
end
