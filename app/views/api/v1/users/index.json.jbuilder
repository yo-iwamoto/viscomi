# jbuilder構文の参考にするコード

# json.array! @users do |user|
#   if user.is_manager === false
#     json.userData do
#       json.extract! user, :id, :name, :email
#     end
#   else
#     json.userData do
#       json.extract! user, :id, :name, :email
#     end
#     json.comData do
#       json.extract! user.community_center, :id, :name
#     end
#   end
# end

json.array! @users, ;name, :email