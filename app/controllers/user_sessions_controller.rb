class UserSessionsController < ApplicationController
  before_action :require_logout, only: [:new, :create]
  before_action :require_login, only: [:destroy]

  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      # redirect_to root_path, success: 'Logged in!'
      redirect_back_or(root_path, 'Logged in!')
    else
      flash.now[:error] = 'Invalid username or password.'
      render :new
    end
  end

  def destroy
    current_user_session.destroy
    redirect_to root_path, success: 'Logged out!'
  end
end
