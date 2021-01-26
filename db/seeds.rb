# サンプルユーザーを20個作成
20.times do |n|
  User.create(
    name: Faker::Name.name,
    email: "user#{n-1}@example.com",
    password: 'foobar',
    activated: true
  )
end

User.create(
  name: '管理者',
  email: 'viscomi10440@gmail.com',
  password: ENV['VIS_MANAGE_PASS'],
  activated: true,
  admin: true
)

# メインの公民館管理者ユーザー設定
user = User.find(1)
user.update(email: 'tenjinyama@example.com')
center = user.create_community_center(
  name: '天神山自治会',
  comment: '初めまして。よろしくお願いします。'
)
center.subscriptions.create(user_id: 1)

# 別の公民館管理者ユーザー設定
user = User.find(2)
user.update(email: 'other.center@example.com')
center = user.create_community_center(
  name: '池之上公民館',
  comment: '池之上町の公民館です。'
)
center.subscriptions.create(user_id: 2)

# ユーザー群設定
(3..10).each do |n|
  user = User.find(n)
  # id: 3~8のユーザーはメインの公民館を, id: 9,10のユーザーは別の公民館をフォロー
  m = n < 9 ? 1 : 2
    CommunityCenter.find(m).subscriptions.create(user_id: user.id)
end

# 3つずつ投稿を作成
(1..2).each do |n|
  center = CommunityCenter.find(n)
  3.times do
    center.posts.create(
      type: 'イベントの告知・報告',
      title: "テスト投稿#{n+1}",
      content: Faker::Lorem.sentence(word_count: 10)
    )
  end
end

# 広告を作成
5.times do |n|
  Ad.create(
    owner_name: Faker::Games::Pokemon.name,
    content: Faker::Lorem.sentence(word_count: 10),
    phone_number: "080#{(0..9).to_a.shuffle.join[0..6]}",
    url: 'https://google.com'
  )
  # id: 1,2,3の広告はメインの公民館に登録
  if n < 3
    CommunityCenter.find(1).ad_registries.create(ad_id: n+1)
  # id: 4の広告は別の公民館に登録
  elsif n < 4
    CommunityCenter.find(2).ad_registries.create(ad_id: n+1)
  # id: 5の広告は両方の公民館に登録
  else
    CommunityCenter.find(1).ad_registries.create(ad_id: n+1)
    CommunityCenter.find(2).ad_registries.create(ad_id: n+1)
  end
end