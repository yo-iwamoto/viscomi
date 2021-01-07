class Api::V1::CommunityCentersController < ApiController

  def index
    @community_centers = CommunityCenter.all
  end

  def show
    @community_center = CommunityCenter.find_by(user_id: params[:id])
    render json: @community_center
  end

  def page
    @community_center = CommunityCenter.find_by(community_center_id: params[:id])
    render json: @community_center
  end
  
  def create
    @user = User.find(params[:id])
    if @user.is_manager
      response_conflict(:community_center)
    elsif @user.authenticate(params[:password])
      @user.new_community_center(params[:name])
      @community_center = CommunityCenter.find_by(user_id: @user.id)
      render 'create'
    else
      response_bad_request
    end
  end

end