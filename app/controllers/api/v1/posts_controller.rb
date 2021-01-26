class Api::V1::PostsController < ApiController

  def index
    @posts = Post.all
  end
  
  def create
    community_center = current_users_center
    @post = community_center.posts.build(post_params)
    unless @post.save
      render json: @post.errors.full_messages
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    response_success
  end

  def image
    community_center = CommunityCenter.find(params[:id])
    post = community_center.posts.first
    # 作成したPostに関連付けてPostImageを作成
    pi = post.build_post_image(image: params[:image])
    pi.save
  end

  private

    def post_params
      params.require(:post).permit(:type, :title, :content)
    end
end