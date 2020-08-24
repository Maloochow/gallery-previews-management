module ClientInvitesHelper

    def edit_client(client)
        invite = client.invite(current_gallery)
        link_to "Edit", edit_gallery_client_invite_path(current_gallery, invite) if edit_authorized?(invite)
    end

    def delete_client(client)
        invite = client.invite(current_gallery)
        link_to "Delete", gallery_client_invite_path(current_gallery, invite), method: 'DELETE' if edit_authorized?(invite)
    end
end
