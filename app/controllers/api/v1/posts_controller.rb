class Api::V1::PostsController < ApiController

  def index
    @posts = Post.all
  end
  
  def create
    community_center = current_user.following
    @post = community_center.posts.build(post_params)
    response_bad_request unless @post.save
    render json: @post.errors.full_messages
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    response_success
  end

  def image
    community_center = CommunityCenter.find(params[:id])
    post = community_center.posts.first
    post.create_post_image(image: params[:image])
  end

  private

    def post_params
      params.require(:post).permit(:type, :title, :content)
    end
end