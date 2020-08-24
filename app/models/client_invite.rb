class ClientInvite < ApplicationRecord
    belongs_to :gallery, optional: true
    belongs_to :user, optional: true
    belongs_to :client

    def self.gallery_clients(gallery)
        invites = self.where(gallery_id: gallery.id)
        invites.map {|invite| invite.client }
    end

    def app_id
        self.client.app_id
    end

    def user_name
        self.user.username
    end

end
