# サンプルユーザーを20個作成
20.times do |n|
  User.create(
    name: Faker::Name.name,
    email: "user#{n-1}@example.com",
    password: 'fooobarr',
    activated: true
  )
end

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

# 投稿用のダミーparams
post_params = [
  {
    type: 'イベントの告知・報告',
    title: '今年の夏祭りについて',
    content: '今年の夏祭りは8/29(土)に○○公園で行われます。たくさんの出店も出店されます。是非お越しください。'
  },
  {
    type: 'イベントの告知・報告',
    title: 'フリーマーケットのお知らせ',
    content: '来週の日曜日に、公民館前でフリーマーケットを行います。ご家庭に不要なものがありましたら、この機会に出品してはいかがでしょうか？'
  },
  {
    type: 'イベントの告知・報告',
    title: '子育てセミナーが開催されます。',
    content: '9/25(日)に、専門講師による子育てセミナーが開催されます。是非お越しください。'
  },
  {
    type: '連絡事項',
    title: '町内会費の徴収',
    content: '今年度分の町内会費を徴収致します。回覧板にて詳細をご連絡いたしますので、お忘れのないよう、よろしくお願い致します。'
  },
  {
    type: '連絡事項',
    title: '今日は燃えないゴミの日です',
    content: '今日は燃えないゴミの日なので、忘れないように出しましょう。'
  }
]

# 5つずつ投稿を作成
(1..2).each do |n|
  center = CommunityCenter.find(n)
  5.times do |m|
    center.posts.create(post_params[m])
  end
end

# 広告用のダミーparams
ad_params = [
  {
    owner_name: 'カフェ イタリアーノ',
    content: '軽食, イタリアン, ピザ',
  },
  {
    owner_name: 'るるるラーメン',
    content: '学割もやってます！'
  },
  {
    owner_name: '中華料理 北京',
    content: '餃子がおすすめです。'
  },
  {
    owner_name: 'ジョイフル 天神山店',
    content: '学校帰りや、家族でのお食事に'
  },
  {
    owner_name: '牧のうどん 天神山店',
    content: 'あったかいおうどんをどうぞ'
  }
]

# 広告を作成
5.times do |n|
  Ad.create(ad_params[n].merge!({
    phone_number: "999#{(0..9).to_a.shuffle.join[0..6]}",
    url: 'https://google.com'
  }))
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

# メール作成
community_center = CommunityCenter.first
community_center.contacts.create(
  subject: '初めてのメール配信です',
  content: '届いていますでしょうか'
)
community_center.contacts.create(
  subject: '投稿を追加しました',
  content: 'VISCOMIで投稿を作成してみました。是非、アプリ内でご覧になってください。'
)

user = User.create!(
  name: '管理者アカウント',
  email: 'viscomi1040@gmail.com',
  password: ENV['MANAGE_PASS'],
  activated: true
)

AdminUser.create!(
  email: 'viscomi1040@gmail.com', 
  password: ENV['MANAGE_PASS'], 
  password_confirmation: ENV['MANAGE_PASS']
)