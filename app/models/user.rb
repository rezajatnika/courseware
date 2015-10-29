class User < ActiveRecord::Base
  after_initialize :set_default_role, if: :new_record?

  # Associations
  has_many :enrollments, foreign_key: 'student_id', dependent: :destroy
  has_many :courses, foreign_key: 'lecturer_id', dependent: :destroy

  # User authentication
  acts_as_authentic do |c|
    c.crypto_provider = Authlogic::CryptoProviders::SCrypt
  end

  def self.find_login_by(login)
    find_by_username(login) || find_by_email(login)
  end

  def enroll(course)
    # TODO: Implement course enrollment
    enrollments.create(course_id: course.id)
  end

  def unenroll(course)
    # TODO: Implement course unenrollment
    enrollments.find_by(course_id: course.id).destroy
  end

  def enroll?(course)
    # TODO: Implement user enroll?
    # returns true if user already enroll the course
    !self.enrollments.find_by(course_id: course.id).nil?
  end

  def lecturing?(course)
    course.lecturer == self
  end

  # Roles
  enum role: [:student, :lecturer, :admin]

  private

  def set_default_role
    self.role ||= :student
  end
end
