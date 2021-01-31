class Api::V1::UsersController < ApiController

  def index
    @users = User.all
  end

  def create
    @user = User.new(user_params)
    if @user.save
      community_center = CommunityCenter.find_by(name: params[:follow])
      @user.follow(community_center)
      @user.send_activation_email
      response_success
    elsif @user.errors && @user.errors[:email][0] == 'has already been taken'
      response_conflict
    else
      render json: @user.errors.full_messages, status: 400
    end
  end

  def show
    @user = User.includes(:community_center).find(params[:id])
  end

  def update
    id = CommunityCenter.find_by(name: params[:follow]).id
    @user = current_user
    response_bad_request unless @user.update(name: params[:name]) && @user.subscription.update(community_center_id: id)
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password)
    end
end