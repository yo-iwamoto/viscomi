require 'rails_helper'

RSpec.describe "Users", type: :request do
  before do
    users = create_list(:user, 3)
    @user = users.first
    community_centers = create_list(:community_center, 3)
    @community_center = community_centers.first

    # アクセストークンを生成してヘッダーに登録
    payload = { uid: @user.id }
    access_token = JWT.encode payload, nil, 'none'
    @headers = { 'ACCESS-TOKEN': access_token }
  end

  # show
  it 'get specific user' do
    @user.update(name: 'THIS')

    get "/api/v1/users/#{@user.id}", headers: @headers
    json = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(json['name']).to eq('THIS')
  end

  # create
  it 'create user' do
    create_params = {
      user: {
        name: 'test user',
        email: 'test@example.com',
        password: 'foobarbaz'
      },
      follow: @community_center.name
    }

    post '/api/v1/users', params: create_params
    json = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(User.find_by(name: 'test user').nil?).to be_falsy
  end

  # update
  it 'update user' do
    update_params = { user: {name: 'UPDATED' } }

    patch "/api/v1/users/#{@user.id}", headers: @headers, params: update_params
    json = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(User.find(@user.id).name).to eq('UPDATED')
  end

  # destroy
  it 'destroy user' do
    id = @user.id
    id.freeze
    
    delete "/api/v1/users/#{@user.id}", headers: @headers
    json = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(User.where(id: id).count).to eq(0)
  end
end
