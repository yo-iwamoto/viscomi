json.array! @posts do |post|
  json.extract! post, :type, :title, :content, :post_image, :community_center_id, :formatted_date
end