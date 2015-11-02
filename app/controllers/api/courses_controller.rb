module Api
  class CoursesController < ApplicationController
    respond_to :json

    def index
      @courses = Course.order(id: 'asc').all
      respond_with(@courses)
    end
  end
end
