class ClientInvitesController < ApplicationController
    before_action :authorized?, :set_invite

    def edit
    end

    def update
        @invite.update(invite_params)
        @invite.save
        redirect_to gallery_client_path(current_gallery, @invite.client)
    end

    def destroy
        if edit_authorized?(@invite)
            @invite.gallery_id = nil
            @invite.save
            redirect_to gallery_clients_path(current_gallery)
        else
            redirect_to gallery_client_path(current_gallery, @invite.client)
        end
    end

    private

    def invite_params
        params.require(:client_invite).permit(:status)
    end

    def set_invite
        @invite ||= ClientInvite.find_by_id(params[:id])
    end
end
