class UsersController < ApplicationController
  before_action :require_logout

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path, success: 'You are now registered.'
    else
      render :new
    end
  end

  private

  def user_params
    user_attr = [:username, :email, :password, :password_confirmation]
    params.require(:user).permit(*user_attr)
  end
end
