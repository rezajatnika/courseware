class User < ActiveRecord::Base
  after_initialize :set_default_role, if: :new_record?

  # User authentication
  acts_as_authentic do |c|
    c.crypto_provider = Authlogic::CryptoProviders::SCrypt
  end

  def self.find_login_by(login)
    find_by_username(login) || find_by_email(login)
  end

  # Roles
  enum role: [:student, :lecturer, :admin]

  private

  def set_default_role
    self.role ||= :student
  end
end
