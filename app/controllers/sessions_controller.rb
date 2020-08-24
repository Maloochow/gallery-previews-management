class SessionsController < ApplicationController

  def new
    if current_user
      redirect_to user_path(@user)
    else
    @user = User.new
    end
  end
  
  def create
    @user = User.find_by_email(user_params[:email])
    if @user && @user.authenticate(user_params[:password])
      session[:user_id] = @user.id
      session[:gallery_id] = @user.gallery.id if @user.gallery
      redirect_to user_path(@user)
    else
      flash.now[:alert] = "User email not exist or the password is invalid. Please try again"
      @user = User.new
      render :new
    end
  end
  
  def google_login
    user = User.find_or_create_from_omniauth(user_info)
    session[:user_id] = user.id
    session[:gallery_id] = user.gallery.id if user.gallery
    redirect_to user_path(user)
  end

  def destroy
    session.clear
    redirect_to login_path
  end

  private

  def user_info
    request.env['omniauth.auth'][:info]
  end

  def user_params
    params.require("user").permit(:email, :password)
  end

end
