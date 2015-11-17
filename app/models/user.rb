class User < ActiveRecord::Base
  after_initialize :set_default_role, if: :new_record?

  USERNAME_REGEX = /\A[a-zA-Z0-9_][a-zA-Z0-9\.+\-_@]+\z/

  # Associations
  has_many :enrollments, foreign_key: 'student_id', dependent: :destroy
  has_many :courses, foreign_key: 'lecturer_id', dependent: :destroy
  has_many :enrolled_courses, through: :enrollments, source: :course
  has_many :feeds, foreign_key: 'lecturer_id', dependent: :destroy

  # User authentication
  acts_as_authentic do |c|
    c.crypto_provider = Authlogic::CryptoProviders::SCrypt
    c.validates_length_of_login_field_options = { in: 5..25 }
    c.validates_format_of_login_field_options = {
      with: USERNAME_REGEX,
      message: 'should use only letters, numbers, and .-_@+ please'
    }
    c.merge_validates_format_of_email_field_options(
      message: 'should use valid email address format'
    )
    c.merge_validates_length_of_password_field_options(in: 8..30)
  end

  def change_current_password!(current, new_password, confirmation)
    if (new_password == confirmation && self.valid_password?(current))
      update_attributes!(
        password: new_password,
        password_confirmation: confirmation
      )
    end
  end

  def self.find_login_by(login)
    find_by_username(login) || find_by_email(login)
  end

  def enroll(course)
    enrollments.create(course_id: course.id)
  end

  def unenroll(course)
    enrollments.find_by(course_id: course.id).destroy
  end

  def enroll?(course)
    !self.enrollments.find_by(course_id: course.id).nil?
  end

  def create_feed(content, course)
    feeds.create(content: content, course_id: course.id)
  end

  def activate!
    self.active = true
    save
  end

  def deliver_activation_instructions!
    reset_perishable_token!
    UserMailer.activation_instructions(self).deliver_later
  end

  # Roles
  enum role: [:student, :lecturer, :admin]

  private

  def set_default_role
    self.role ||= :student
  end
end
