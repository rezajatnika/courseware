module Api
  class CoursesController < ApplicationController
    respond_to :json

    def index
      @courses = Course.order(id: 'asc').all
      respond_with(@courses)
    end

    def show
      @course = Course.find(params[:id])
      respond_with(@course)
    end
  end
end
