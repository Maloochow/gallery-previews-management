class UserInvitesController < ApplicationController
    before_action :authorized?, except: :enter

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

    def enter
        if show_on_gallery
            invite = show_on_gallery.user_invites.where(new_user_email: current_user.email)[0]
            if invite
                show_on_gallery.users << current_user
                session[:gallery_id] = show_on_gallery.id
                UserInvite.where(new_user_email: current_user.email).destroy_all
                redirect_to gallery_path(current_gallery)
            else
                redirect_to user_path(current_user)
            end
        else
            redirect_to user_path(current_user)
        end
    end

    private

    def invite_params
        params.require(:user_invite).permit(:user_id, :new_user_email)
    end
end
