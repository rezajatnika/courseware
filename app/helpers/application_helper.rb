module ApplicationHelper
  def current_user_session
    @current_user_session ||= UserSession.find
  end

  def current_user
    @current_user = current_user_session && current_user_session.user
  end

  def current_permission
    @current_permission ||= Permission.new(current_user)
  end

  def current_resource
    nil
  end
end
