User.create!(
  name: "Manager User",
  email: "manager@example.com",
  password: "foobar",
  activated: true
)

password = "foobar"

5.times do |n|
  name = Faker::Name.name
  email = "sample#{n+1}@example.com"
  User.create(
    name: name,
    email: email,
    password: password,
    activated: true
  )
end

5.times do |n|
  name = Faker::Name.name
  email = "sample#{n+6}@example.com"
  User.create(
    name: name,
    email: email,
    password: password,
    activated: true
  )
  u = User.find(n+6)
  u.new_community_center("#{n+6}丁目公民館")
end
