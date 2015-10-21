class Enrollment < ActiveRecord::Base
  # Associations
  belongs_to :student, class_name: 'User'
  belongs_to :course

  # Validations
  validates :course_id, uniqueness: { scope: :student_id }
end
