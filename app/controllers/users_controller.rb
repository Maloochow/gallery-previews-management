class UsersController < ApplicationController

    def index
        authorized?
        users = @gallery.users
        if params[:search]
            @users = users.search(params[:search])
        else
            @users = users
        end
    end

    def new
        @user = User.new
    end

    def create 
        @user = User.new(user_info)
        if user_params[:password] != user_params[:password_confirmation]
            flash[:alert] = "password confirmation has to be the same as password"
            render :new
        elsif @user.save
        session[:user_id] = @user.id
        redirect_to user_path(@user)
        else
            flash[:alert] = "Email already exist, please login or use a different email"
            render :new
        end
    end

    def show
        authorized?
    end

    def edit
        if current_user != show_user
            redirect_to gallery_users_path(current_gallery)
        end
    end

    def update
        if current_user != show_user
            redirect_to gallery_users_path(current_gallery)
        else
            if @user.update(user_info)
                redirect_to gallery_user_path(current_gallery, @user)
            else
                render :edit
            end
        end
    end

    def pre_gallery
        if  current_gallery && current_user.gallery == current_gallery
            redirect_to gallery_path(current_gallery)
        elsif current_user.gallery.nil?
            @gallery = Gallery.new
            render :pre_gallery
        else
            session.clear
            redirect_to login_path
        end
    end

    def destroy
        if gallery_admin? && show_user.gallery == current_gallery && show_user != current_gallery.admin
            show_user.gallery_id = nil
            show_user.save
            redirect_to gallery_users_path(current_gallery)
        else
            flash[:alert] = "Operation is prohibited"
            redirect_to gallery_user_path(current_gallery, show_user)
        end
    end

private

    def user_params
        params.require("user").permit(:username, :email, :password, :password_confirmation)
    end

    def user_info
        {username: user_params[:username],
        email: user_params[:email],
        password: user_params[:password]}
    end


end

