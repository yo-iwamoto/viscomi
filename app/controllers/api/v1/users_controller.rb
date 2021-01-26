class Api::V1::UsersController < ApiController

  def index
    @users = User.all
  end

  def create
    @user = User.includes(:community_center).new(user_params)
    if @user.save
      community_center = CommunityCenter.find_by(name: params[:user][:follow])
      community_center.subscriptions.create(user_id: @user.id)
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
    @user = User.includes(:community_center).find(params[:id])
    response_bad_request unless @user.update(user_params)
    render 'update'
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password)
    end
end