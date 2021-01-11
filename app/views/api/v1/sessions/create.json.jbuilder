if @user.is_manager == false
  json.userData do
    json.extract! @user, :id, :name, :email, :is_manager, :community_center_id
  end
else
  json.userData do
    json.extract! @user, :id, :name, :email, :is_manager, :community_center_id
  end
  json.comData do
    json.extract! @user.community_center, :id, :name, :comment, :user_id
  end
end