class Feed < ActiveRecord::Base
  belongs_to :course
  belongs_to :lecturer, class_name: 'User'
end
