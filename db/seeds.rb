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
    avatar: "https://robohash.org/#{rand(5000)}.png",
    created_at: Faker::Time.between(8.months.ago, 7.months.ago, :all)
  )
end

2000.times do
  Post.create!(
    body: Faker::Hipster.sentence(5),
    user: user.sample,
    created_at: Faker::Time.between(6.months.ago, Date.today, :all)
    )
end

500.times do
  user1 = user.sample
  user2 = nil
  until !user2.blank? && user2 != user1
    user2 = user.sample
  end
  user1.follow!(user2)
end
