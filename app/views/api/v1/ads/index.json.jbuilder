json.array! @ads do |ad|
  json.extract! ad, :id, :owner_name, :content, :phone_number, :url, :ad_image
end