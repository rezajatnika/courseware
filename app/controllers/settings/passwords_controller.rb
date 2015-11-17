module Settings
  class PasswordsController < ApplicationController
    before_action :require_login

    def show
      @user = current_user
    end

    def create
      @user = current_user
      if @user.change_current_password!(
          params[:user][:current_password],
          params[:user][:new_password],
          params[:user][:new_password_confirmation])
        flash[:success] = 'Your password has been changed!'
        redirect_to settings_password_path
      else
        flash.now[:error] = 'Error happen!'
        render :show
      end
    end
  end
end
