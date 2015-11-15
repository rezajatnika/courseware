class ApplicationController < ActionController::Base
  before_filter :set_mailer_host

  # Includes
  include ApplicationHelper

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Flash types
  add_flash_types :success, :info, :warning

  # Helper method
  helper_method :allow?, :allow_param?
  delegate :allow?, to: :current_permission
  delegate :allow_param?, to: :current_permission

  private

  def set_mailer_host
    ActionMailer::Base.default_url_options[:host] = request.host_with_port
  end

  def require_login
    unless current_user
      store_location
      redirect_to new_user_session_path, warning: 'Please login first!'
    end
  end

  def require_logout
    redirect_to root_path if current_user
  end

  def redirect_back_or(default, message)
    redirect_to((session[:return_to] || default), success: message)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url if request.get?
  end

  def decode(string)
    Base64.urlsafe_decode64(string)
  end

  def authorize_user
    unless current_permission.allow?(
        params[:controller],
        params[:action],
        current_resource)
      begin
        redirect_to :back, warning: 'Not authorized!'
      rescue ActionController::RedirectBackError
        redirect_to root_path, warning: 'Not authorized!'
      end
    end
  end

  def authorize
    if current_permission.allow?(
        params[:controller],
        params[:action],
        current_resource)
      current_permission.permit_params!(params)
    else
      redirect_to root_path, warning: 'Not authorized!'
    end
  end
end
