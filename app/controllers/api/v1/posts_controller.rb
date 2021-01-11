class Api::V1::PostsController < ApiController

  def index
    @posts = Post.all
  end
  
  def create
    @community_center = CommunityCenter.find(params[:comId])
    @post = @community_center.posts.build(post_params)
    unless @post.save
      render json: @post.errors.full_messages
    end
  end

  def timeline
    @community_center = CommunityCenter.find(params[:id])
    @posts = @community_center.posts
    render 'timeline'
  end

  private

    def post_params
      params.require(:post).permit(:type, :title, :content)
    end
end