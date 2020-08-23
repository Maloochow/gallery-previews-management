class UsersController < ApplicationController

    def index
        @gallery = Gallery.find_by_id(params[:gallery_id])
        @users = User.all.where(gallery_id: @gallery.id)
    end

    def new
        @user = User.new
    end

    def create 
        if user_params[:password] != params[:user][:password_confirmation]
            # @user = User.new(username: user_params[:username], email: user_params[:email])
            flash[:alert] = "password confirmation has to be the same as password"
            render :new && return
        end
        user = User.find_by(email: user_params["email"])
        if user
            flash[:alert] = "User email already exist. Please login or use a different email."
            render :new
        else
        @user = User.new(user_params)
        binding.pry
            if @user.save
            session[:user_id] = @user.id
            redirect_to user_path(@user)
            else
                flash[:alert] = "User input invalid. Please try again"
                render :new
            end
        end
    end

    def edit

    end

    def update

    end

    def show

    end

    def destroy

    end

private

    def user_params
        params.require("user").permit(:username, :email, :password)
    end


end

