class FeedsController < ApplicationController
  def create
    @course = Course.find_by_slug(params[:course_id])
    @feed = current_user.feeds.build(feed_params)
    @feed.course = @course
    if @feed.save
      redirect_to @course
    else
      render text: @feed.errors.full_messages
    end
  end

  private

  def feed_params
    params.require(:feed).permit(:content)
  end
end
