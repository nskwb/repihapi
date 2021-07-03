User.create!(name: "Nishikawa Mameta",
             email: "mametacrypto@gmail.com",
            password: "password",
            confirmed_at: Time.now)

50.times do |n|
  name = "ユーザーNo.#{n+1}"
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
                email: email,
                password:  password,
                confirmed_at: Time.now)
end

users = User.order(:created_at).take(3)
20.times do |n|
  users.each do |user|
    user.posts.create!(name: "#{user.id} #{n+1}回目の投稿",
                      content: "#{n+1}回目の投稿のコンテンツ",
                      serve: 2,
                      protein: 100,
                      fat: 200,
                      carbo: 300,
                      calorie: 600)
  end
end
