class UserInvite < ApplicationRecord
    belongs_to :user
    
    def gallery_name
        self.gallery.name
    end

    def gallery
        self.user.gallery
    end
end
