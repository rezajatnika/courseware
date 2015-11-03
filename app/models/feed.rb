class Feed < ActiveRecord::Base
  belongs_to :course
  belongs_to :lecturer, class_name: 'User'

  validates :content, :lecturer_id, :course_id, presence: true
end
