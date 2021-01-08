class Api::V1::PostsController < ApiController
  def create
    @community_center = CommunityCenter.find(params[:comId])
    @post = @community_center.posts.build(post_params)
    if @post.save
      render 'create'
    else
      render json: @post.errors.full_messages
    end
  end

  private

    def post_params
      params.require(:post).permit(:type, :title, :content, :image)
    end
end