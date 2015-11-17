class UsersController < ApplicationController
  before_action :require_logout, only: [:new, :show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save_without_session_maintenance
      @user.deliver_activation_instructions!
      flash[:info] = %Q{
        Please check activation instruction at your #{@user.email} account.
      }
      redirect_to root_path
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
