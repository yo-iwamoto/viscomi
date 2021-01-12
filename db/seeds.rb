password = 'foobar'

2.times do |n|
  name = Faker::Name.name
  email = "manager#{n+1}@example.com"
  User.create(
    name: name,
    email: email,
    password: password,
    activated: true
  )
  c = User.find(n+1).new_community_center(
    "#{n+1}丁目公民館",
    "初めまして。よろしくお願い致します。"
  )
  c.subscriptions.create(follower_id: n+1)
  CommunityCenter.find(n+1).posts.build(
    type: 'イベントの報告',
    title: "#{n+1}丁目公民館、VISCOMI始めました",
    content: '今後、様々な情報をお届けします。'
  )
end

5.times do |n|
  name = Faker::Name.name
  email = "user#{n+1}@example.com"
  User.create(
    name: name,
    email: email,
    password: password,
    activated: true
  )
  c = CommunityCenter.find(1).subscriptions.create(follower_id: n+3)
end

5.times do |n|
  name = Faker::Name.name
  email = "user#{n+6}@example.com"
  User.create(
    name: name,
    email: email,
    password: password,
    activated: true
  )
  c = CommunityCenter.find(2).subscriptions.create(follower_id: n+8)
end