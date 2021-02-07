class ApiController < ActionController::API
  # 200 Success
  # json（データ）を返す必要がない場合に利用する
  def response_success
    render status: 200, json: { status: 200, message: "Success" }
  end

  # 400 Bad Request
  def response_bad_request
    render status: 400, json: { status: 400, message: 'Bad Request' }
  end

  # 401 Unauthorized
  def response_unauthorized
    render status: 401, json: { status: 401, message: 'Unauthorized' }
  end

  # 404 Not Found
  def response_not_found
    render status: 404, json: { status: 404, message: "Not Found" }
  end

  # 409 Conflict
  def response_conflict
    render status: 409, json: { status: 409, message: "Conflict" }
  end

  # 500 Internal Server Error
  def response_internal_server_error
    render status: 500, json: { status: 500, message: 'Internal Server Error' }
  end

  # 非ログインユーザーのアクセスをはじく
  def authenticate_user?
    response_bad_request unless request.headers['Access-Token']
  end

  # access_tokenをデコードして、uidからユーザーをセットする
  def current_user
    User.find_by!(id: decode_access_token[0]['uid'])
  end

  # ユーザーが引数のcommunity_centerの管理者であるかどうか
  def correct_community_center?(community_center)
    current_user.community_center == community_center
  end

  private

    # request headerのaccess_tokenをデコード
    def decode_access_token
      token = request.headers['Access-Token']
      JWT.decode token, nil, false
    end

end