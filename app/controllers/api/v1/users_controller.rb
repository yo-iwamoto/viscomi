class Api::V1::UsersController < ApiController

  def index
    @users = User.all
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: User.find(@user.id), status: 200
    else
      response_bad_request
    end
  end

  def sample
    user = User.find(params[:user][:id] + 1)
    render json: user
  end

  def show
    @user = User.find(params[:id])
    render json: @user
  end

  def update
    @user = User.find(params[:id])
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :image)
    end
end