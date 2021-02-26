class Api::V1::UsersController < ApiController
  before_action :authenticate_user?, only: %i[index show update destroy]
  before_action :correct_user?, only: %i[update destroy]

  def index
    response_bad_request unless current_user.is_manager
    @users = current_user.community_center.followers
  end

  def show
    @user = current_user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      community_center = CommunityCenter.find_by(name: params[:follow])
      @user.follow(community_center)
      @user.notifications.create(title: 'ビズコミへようこそ！', content: '会員登録が完了しました。')
      community_center.user.notifications.create(title: 'お知らせ', content: '新しいユーザーが公民館を登録しました。')
      # @user.send_activation_email
      @user.activate
      response_success
    elsif @user.errors && @user.errors[:email][0] == 'はすでに存在します'
      response_conflict
    else
      render json: @user.errors.full_messages, status: 400
    end
  end

  def update
    @user = current_user
    response_bad_request unless @user.update(update_user_params)
  end

  def destroy
    @user = current_user
    response_bad_request unless @user.destroy
    response_success
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password)
    end

    def update_user_params
      params.require(:user).permit(:name, :mute_contact)
    end
    
    def correct_user?
      response_bad_request unless current_user.id == params[:id].to_i
    end
end