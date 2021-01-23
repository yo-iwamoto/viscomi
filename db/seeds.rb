# 動作確認用

password = 'foobar'

u = User.create(
  name: Faker::Name.name,
  email: "tenjinyama@example.com",
  password: password,
  activated: true
)
c = u.new_community_center(
  "天神山自治会",
  "初めまして。よろしくお願いします。"
)
c.subscriptions.create(follower_id: 1)

u = User.create(
  name: Faker::Name.name,
  email: "other.center@example.com",
  password: password,
  activated: true
)
c = u.new_community_center(
  "池之上町公民館",
  "池之上町の公民館です。"
)
c.subscriptions.create(follower_id: 1)

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

# ポートフォリオ確認用
