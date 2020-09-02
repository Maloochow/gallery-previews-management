class ApplicationController < ActionController::Base
    helper_method :current_user, :show_user, :current_gallery, :show_gallery, :authorized?, :edit_authorized?, :gallery_admin?, :show_on_gallery

    def current_user
        @user ||= User.find_by_id(session[:user_id])
    end

    def current_gallery
        @gallery ||= Gallery.find_by_id(session[:gallery_id])
    end

    def show_user
        @show_user ||= User.find_by_id(params[:id])
    end

    def show_gallery
        @show_gallery ||= Gallery.find_by_id(params[:gallery_id])
    end

    def show_on_gallery
        @show_gallery ||= Gallery.find_by_id(params[:id])
    end

    def authorized?
        if current_gallery && current_user
            if show_gallery == current_user.gallery && show_gallery == current_gallery
                true
            else
                session.clear
                redirect_to login_path and return
            end
        else
            flash[:alert] = "Please login"
            redirect_to login_path
        end
    end

    def edit_authorized?(obj)
        gallery_admin? || current_user == obj.user
    end

    def gallery_admin?
        current_user == current_gallery.admin
    end
end
