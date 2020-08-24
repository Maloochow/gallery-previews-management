class UserInvitesController < ApplicationController
    before_action :authorized?

    def new
        authorized?
        @user_invite = UserInvite.new
    end

    def create
    user_invite = UserInvite.create(invite_params)
    redirect_to gallery_users_path(current_gallery)
    end

    def destroy
        user_invite = UserInvite.find_by_id(params[:id])
        user_invite.destroy
        redirect_to gallery_users_path(current_gallery)
    end

    private

    def invite_params
        params.require(:user_invite).permit(:user_id, :new_user_email)
    end
end
