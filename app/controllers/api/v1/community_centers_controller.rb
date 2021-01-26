class Api::V1::CommunityCentersController < ApiController

  # 公民館選択用のAPIで、nameのみを返す
  def index
    @community_centers = CommunityCenter.all
  end

  def show
    @community_center = current_user.following
    response_bad_request if !@community_center
  end
  
  def create
    @user = current_user
    response_conflict if @user.is_manager
    response_bad_request unless params[:password] == ENV['MANAGE_PASS']
    @user.create_community_center(name: params[:name])
    @community_center = CommunityCenter.find_by(user_id: @user.id)
    @community_center.subscriptions.create(user_id: @user.id)
  end

  def update
    @community_center = CommunityCenter.find(params[:id])
    if @community_center.update(name: params[:name], comment: params[:comment])
      render 'update'
    else
      render @community_center.errors.full_messages, status: 400
    end 
  end


  def names
    @community_centers = CommunityCenter.all
    render 'names'
  end

end