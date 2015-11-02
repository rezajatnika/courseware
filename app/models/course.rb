class Course < ActiveRecord::Base
  # Associations
  has_many :enrollments, foreign_key: :course_id, dependent: :destroy
  has_many :students, class_name: 'User', through: 'enrollments'
  has_many :feeds

  belongs_to :lecturer, class_name: 'User'

  # Validations
  validates :name, presence: true
  validates :code, presence: true

  def as_json(options = {})
    super(only: [:id, :name, :code])
  end

  private

  def current_permission
    @current_permission ||= Permission.new(current_user)
  end

  def authorize
    # TODO: Implement authorize method on course model
  end
end
