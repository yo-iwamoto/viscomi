json.userData do
  json.extract! @user, :id, :name, :email, :is_manager
end