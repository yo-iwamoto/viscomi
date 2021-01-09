if @user.is_manager == false
  json.userData do
    json.extract! @user, :id, :name, :email, :is_manager
  end
else
  json.userData do
    json.extract! @user, :id, :name, :email, :is_manager
  end
  json.comData do
    json.extract! @user.community_center, :id, :name, :user_id
  end
end