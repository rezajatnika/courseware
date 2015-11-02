class Permission < Struct.new(:user)
  def allow?(controller, action)
    user && user.lecturer?
  end
end
