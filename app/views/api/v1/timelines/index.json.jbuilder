json.posts do
  json.array! @posts do |post|
    json.extract! post, :id, :type, :title, :content, :post_image, :community_center_id, :formatted_date
  end
end
json.ads do
  json.array! @ads do |ad|
    json.extract! ad, :id, :owner_name, :content, :phone_number, :url, :ad_image
  end
end