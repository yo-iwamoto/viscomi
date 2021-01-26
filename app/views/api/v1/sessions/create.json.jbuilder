if !@user.is_manager
  json.userData do
    json.extract! @user, :id, :name, :email, :is_manager, :community_center_id, :following, :admin
  end
else
  json.userData do
    json.extract! @user, :id, :name, :email, :is_manager, :community_center_id, :following, :admin
  end
  json.comData do
    json.extract! @user.community_center, :id, :name, :comment, :user_id
  end
end