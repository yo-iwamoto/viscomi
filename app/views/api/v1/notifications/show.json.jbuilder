json.array! @notifications do |notification|
  json.extract! notification, :id, :title, :content, :read
end