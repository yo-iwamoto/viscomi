json.array! @posts do |post|
  json.extract! post, :type, :title, :content, :community_center_id
end