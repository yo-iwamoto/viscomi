class Api::V1::CommunityCentersController < ApiController

  def index
    @community_centers = CommunityCenter.all
  end

  def show
    @community_center = CommunityCenter.find(params[:id])
    if @community_center == nil
      response_bad_request
    else
      render 'show'
    end
  end

  def page
    @community_center = CommunityCenter.find_by(community_center_id: params[:id])
    render 'show'
  end
  
  def create
    @user = User.find(params[:userId])
    if @user.is_manager
      response_conflict
    elsif params[:password] == ENV['MANAGE_PASS']
      @user.new_community_center(params[:name])
      @community_center = CommunityCenter.find_by(user_id: @user.id)
      render 'create'
    else
      response_bad_request
    end
  end

end