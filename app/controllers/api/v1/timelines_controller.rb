class Api::V1::TimelinesController < ApiController
  before_action :authenticate_user?

  def index
    community_center = current_user.following
    @posts = community_center.posts
    @ads   = community_center.ads
  end

end
