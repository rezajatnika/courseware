class Course < ActiveRecord::Base
  # Associations
  has_many :enrollments, foreign_key: :course_id, dependent: :destroy
  has_many :students, class_name: 'User', through: 'enrollments',
    dependent: :destroy

  belongs_to :lecturer, class_name: 'User'

  # Validations
  validates :name, presence: true
  validates :code, presence: true
end
