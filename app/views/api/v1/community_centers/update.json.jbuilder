json.userData do
  json.extract! @user, :id, :name, :email, :is_manager, :community_center_id, :following
end
