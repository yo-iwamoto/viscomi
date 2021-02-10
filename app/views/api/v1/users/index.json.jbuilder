json.array! @users do |user|
  json.extract! user, :id, :name, :email, :mute_contact, :initial
end