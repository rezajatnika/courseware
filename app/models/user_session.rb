class UserSession < Authlogic::Session::Base
  # Login using username or email
  find_by_login_method :find_login_by
end
