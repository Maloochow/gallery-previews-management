class GalleriesController < ApplicationController
    before_action :gallery_authorized?, except: :create
    # layout 'gallery_nav'

    def create
        @gallery = Gallery.new(gallery_params)
        if @gallery.save
            @gallery.users << current_user
            @gallery.admin_user_id = @user.id
            @gallery.save
            session[:gallery_id] = @gallery.id
            UserInvite.where(new_user_email: current_user.email).destroy_all
            redirect_to gallery_path(@gallery)
        else
            flash.now[:alert] = "Gallery already exist. Please contact the gallery or user a different name."
            current_user
            render :'users/show'
        end
    end

    def edit
        if !gallery_admin?
            redirect_to gallery_path(current_gallery)
        end
    end

    def update
        if !gallery_admin?
            redirect_to gallery_path(current_gallery)
        else
            if @gallery.update(gallery_params)
                redirect_to gallery_path(current_gallery)
            else
                flash[:alert] = "Name has to be unique"
                render :edit
            end
        end      
    end

    def show
    end

    def destroy
        if !gallery_admin?
            redirect_to gallery_path(current_gallery)
        else
            current_gallery.destroy
            redirect_to user_path(current_user)
        end
    end


    private

    def gallery_params
        params.require("gallery").permit(:name, :admin_user_id)
    end

    def gallery_authorized?
        if current_user && current_gallery
            if show_on_gallery == current_user.gallery && show_on_gallery == current_gallery
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

end
