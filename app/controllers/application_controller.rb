class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Helper methods
  helper_method :current_user, :current_user_session

  # Flash types
  add_flash_types :success, :info, :warning

  private

  def current_user_session
    @current_user_session ||= UserSession.find
  end

  def current_user
    @current_user = current_user_session && current_user_session.user
  end

  def require_login
    unless current_user
      store_location
      redirect_to new_user_session_path
    end
  end

  def require_logout
    redirect_to root_path if current_user
  end

  def redirect_back_or_default(default, message)
    redirect_to((session[:return_to] || default), warning: message)
    session[:return_to] = nil
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url if request.get?
  end
end
