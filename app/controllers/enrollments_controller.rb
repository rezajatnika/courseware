class EnrollmentsController < ApplicationController
  before_action :require_login

  def create
    course = Course.find(params[:course_id])
    current_user.enroll(course)
    redirect_to course, success: 'You are enrolled to this course!'
  end
end
