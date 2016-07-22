# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = 100.times.map do
  User.create!(
    username: Faker::Internet.user_name(nil, %w(_-)),
    email: Faker::Internet.safe_email,
    password: "password",
    password_confirmation: "password",
    avatar: "https://unsplash.it/300/300?image=#{rand(1084)}",
    created_at: Faker::Date.between(7.months.ago, Date.today)
  )
end

2000.times do
  Post.create!(
    body: Faker::Lorem.words(12),
    user: user.sample,
    created_at: Faker::Date.between(6.months.ago, Date.today)
    )
end
