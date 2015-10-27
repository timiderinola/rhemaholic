# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create!(name: "Timilehin Aderinola",
            email: "timiderinola@gmail.com",
            password: "password",
            password_confirmation: "password",
            admin: true)

User.create!(name: "Tomilola Periola",
            email: "tomidamilola@gmail.com",
            password: "password",
            password_confirmation: "password")

99.times do |n|
  name = Faker::Name.name
  email = "user-#{n+1}@gmail.com"
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password)
end