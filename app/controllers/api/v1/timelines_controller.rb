class Api::V1::TimelinesController < ApiController
  def index
    community_center = current_user.following
    @posts = community_center.posts
    @ads   = community_center.ads
  end
end
