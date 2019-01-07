# frozen_string_literal: true

User.create(
  email: 'ryto.verkar@gmail.com',
  password: 'password',
  password_confirmation: 'password',
  first_name: Faker::Name.male_first_name,
  last_name: Faker::Name.last_name,
  birthday: Faker::Date.birthday(18, 65),
  gender: "male",
  bio: Faker::Lorem.sentence(3)
)

50.times do
  User.create(
    email: Faker::Internet.email,
    password: 'password',
    password_confirmation: 'password',
  first_name: Faker::Name.male_first_name,
  last_name: Faker::Name.last_name,
  birthday: Faker::Date.birthday(18, 65),
  gender: "male",
  bio: Faker::Lorem.sentence(3)
  )
end
