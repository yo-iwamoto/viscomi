class Api::V1::CommunityCentersController < ApiController
  before_action :authenticate_user?, only: %i[index show update destroy]

  def index
    @community_centers = CommunityCenter.all
  end

  def show
    @community_center = CommunityCenter.find_by!(id: params[:id])
    response_unauthorized unless current_user == @community_center.user
  end

  def create
    response_bad_request unless params[:managerData][:password] == ENV['MANAGE_PASS']
    @user = User.create(
      name: params[:userData][:name],
      email: params[:userData][:email],
      password: params[:userData][:password],
      activated: true
    )
    if @user.errors && @user.errors[:email][0] == 'はすでに存在します'
      response_conflict
    else
      community_center = @user.create_community_center(name: params[:managerData][:name])
      community_center.subscriptions.create(user_id: @user.id)
    end
  end

  def update
    response_bad_request unless current_user.is_manager
    community_center = current_user.community_center
    response_bad_request unless community_center.update(update_community_center_params)
    @user = current_user
  end

  def destroy
  end

  def image
    response_bad_request unless current_user.is_manager
    community_center = current_user.community_center
    unless community_center.create_community_center_image(image: params[:image])
      response_bad_request
    end
    response_success
  end

  private

    def community_center_params
      params.require(:community_center).permit(:name)
    end

    def update_community_center_params
      params.require(:community_center).permit(:name, :comment)
    end
end