class CoursesController < ApplicationController
  before_action :require_login, only: [:show]
  before_action :authorize_user, only: [:new, :create]

  def index
    @courses = Course.all
  end

  def show
    @course = current_resource
  end

  def new
    @course = current_user.courses.new
  end

  def create
    @course = current_user.courses.build(course_params)
    if @course.save
      redirect_to @course
    else
      render :new
    end
  end

  private

  def current_resource
    @current_resource ||= Course.find_by_slug(params[:id])
  end

  def course_params
    params.require(:course).permit(:name, :code)
  end
end
