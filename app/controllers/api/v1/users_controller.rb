class Api::V1::UsersController < ApiController

  def index
    @users = User.all
  end

  def create
    @user = User.includes(:community_center).new(user_params)
    if @user.save
      @user.send_activation_email
      response_success
    elsif @user.errors && @user.errors[:email][0] == 'has already been taken'
      response_conflict
    else
      render json: @user.errors.full_messages
    end
  end

  def show
    @user = User.includes(:community_center).find(params[:id])
    render 'show'
  end

  def update
    @user = User.includes(:community_center).find(params[:id])
    if @user.update(user_params)
      render 'update'
    else
      response_bad_request
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password)
    end
end