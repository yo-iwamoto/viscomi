class Api::V1::UsersController < ApiController
  before_action :authenticate_user?, only: %i[show update destroy]

  def show
    @user = current_user
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

  def update
    @user = current_user
    id = CommunityCenter.find_by(name: params[:follow]).id
    response_bad_request unless @user.update(update_user_params) && @user.subscription.update(community_center_id: id)
  end

  def destroy
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password)
    end

    def update_user_params
      params.require(:user).permit(:name, :mute_notification)
    end
end