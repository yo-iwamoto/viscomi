class Api::V1::UsersController < ApiController
  before_action :set_user, only: [:show]

  # ActiveRecordのレコードが見つからなければ404 not foundを応答する
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: '404 not found' }, status: 404
  end

  def index
    users = User.all
    render json: users
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: User.find(@user.id)
    else
      render json: { error: '400 bad request' }, status: 400
    end
  end

  def show
    render json: @user
  end

  private

    def set_user
      @user = User.find(params[:id])
    end
end