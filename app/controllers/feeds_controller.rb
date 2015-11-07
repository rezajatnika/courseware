class FeedsController < ApplicationController
  before_action :set_course
  before_action :authorize_user

  def create
    @feed = current_user.feeds.build(feed_params)
    @feed.course = @course
    if @feed.save
      redirect_to @course, success: 'Feed created!'
    else
      redirect_to @course, warning: 'Error happen!'
    end
  end

  def destroy
    @feed = Feed.find(params[:id])
    if @feed.destroy
      redirect_to @course, success: 'Feed deleted!'
    else
      redirect_to @course, warning: 'Error happen!'
    end
  end

  private

  def feed_params
    params.require(:feed).permit(:content)
  end

  def set_course
    @course = Course.find_by_slug(params[:course_id])
  end
end
