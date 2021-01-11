json.userData do
  json.extract! @user, :id, :name, :email, :is_manager, :community_center_id
end
json.comData do
  json.extract! @community_center, :id, :name, :user_id
end