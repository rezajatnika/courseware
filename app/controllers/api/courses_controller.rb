module Api
  class CoursesController < ApplicationController
    def index
      @courses = Course.order(id: 'asc').all
      render json: @courses
    end

    def show
      @course = Course.find(params[:id])
      render json: @course
    end
  end
end
