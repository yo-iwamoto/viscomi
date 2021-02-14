class Api::V1::PostsController < ApiController
  before_action :authenticate_user?, only: %i[show create updatedestroy image]

  def index
    response_bad_request unless current_user.is_manager
    @posts = current_user.community_center.posts
  end

  def show
    @post = Post.find_by!(id: params[:id])
  end

  def create
    community_center = current_user.following
    @post = community_center.posts.build(post_params)
    if !@post.save
      render json: @post.errors.full_messages
      return
    end
    community_center.followers.each do |f|
      f.notifications.create(title: 'お知らせ', content: '公民館が新しい投稿を作成しました。')
    end
    response_success
  end

  def update
    @post = Post.find_by!(id: params[:id])
    response_bad_request unless @post.update(post_params)
    
  end

  def destroy
    @post = Post.find_by!(id: params[:id])
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