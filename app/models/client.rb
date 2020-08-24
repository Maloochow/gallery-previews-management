class Client < ApplicationRecord
    has_many :client_invites
    has_many :users, through: :client_invites
    has_many :galleries, through: :client_invites

    validates :app_id, presence: true, uniqueness: true

    scope :search, -> (app) { where("app_id LIKE ?", "%#{app}%")}

    def user_name(gallery)
        self.invite(gallery).user.username
    end

    def status(gallery)
        self.invite(gallery).status
    end

    def invite(gallery)
        self.client_invites.where(gallery_id: gallery.id)[0]
    end
end
