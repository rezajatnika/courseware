class ActivationsController < ApplicationController
  before_filter :require_logout

  def create
    @user = User.find_by_perishable_token(params[:activation_code])
    if @user.active?
      redirect_to root_path, success: 'Your account already activated!'
    elsif @user.activate!
      UserSession.create(@user, false)
      redirect_to root_path, success: 'Welcome to Courseware!'
    else
      redirect_to root_path, warning: 'Error happen!'
    end
  end
end
