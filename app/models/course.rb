class Course < ActiveRecord::Base
  before_validation :generate_slug

  # Associations
  has_many :enrollments, foreign_key: :course_id, dependent: :destroy
  has_many :students, class_name: 'User', through: 'enrollments'
  has_many :feeds

  belongs_to :lecturer, class_name: 'User'

  # Validations
  validates :name, presence: true
  validates :code, presence: true
  validates :lecturer_id, presence: true

  def as_json(options = {})
    super(only: [:id, :name, :code])
  end

  def to_param
    slug
  end

  def encode_course
    Base64.urlsafe_encode64(self.slug)
  end

  private

  def generate_slug
    self.slug ||= name.parameterize
  end
end
