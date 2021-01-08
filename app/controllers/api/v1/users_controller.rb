class Api::V1::UsersController < ApiController

  def index
    @users = User.all
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      response_success(:users, :create)
    elsif @user.errors && @user.errors[:email][0] == 'has already been taken'
      response_conflict(:users)
    else
      response_bad_request
    end
  end

  def show
    @user = User.find(params[:id])
    render 'show'
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      render 'show'
    else
      response_bad_request
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :image)
    end
end