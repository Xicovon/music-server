class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:login, :new, :create]


  def create
    @user = User.find_by!(username: params[:username])
    ##authenticate user credentials
    if !!@user && @user.authenticate(params[:password])
      #set session and redirect on success
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      #error message on fail
      message = "Something went wrong! Make sure your username and password are correct"
      redirect_to login_path, notice: message
    end
  end

  def home
    if logged_in?
      redirect_to user_path(get_user)
    else
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    @user = nil
    redirect_to login_path
  end

  private

  def get_user
    @user = User.find_by_id(session[:user_id])
  end

end
