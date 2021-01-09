json.array! @users do |user|
  json.userData do
    json.extract! user, :id, :name, :email, :is_manager
  end
  json.comData do
    json.extract! @community_center, :id, :name, :user_id
  end
end