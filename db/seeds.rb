User.create!(name: "Nishikawa Mameta",
             email: "mametacrypto@gmail.com",
            password: "password")

4.times do |n|
  name  = "ユーザーNo.#{n+1}"
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
                email: email,
                password:  password)
end
