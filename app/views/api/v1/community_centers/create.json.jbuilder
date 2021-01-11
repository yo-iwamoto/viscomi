json.userData do
  json.extract! @user, :id, :name, :email, :is_manager, :community_center_id, :following_center
end
json.comData do
  json.extract! @community_center, :id, :name, :comment, :user_id
end