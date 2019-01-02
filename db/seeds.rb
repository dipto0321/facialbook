# frozen_string_literal: true

User.create(
  email: 'ryto.verkar@gmail.com',
  password: 'password',
  password_confirmation: 'password'
)

5.times do
  User.create(
    email: Faker::Internet.email,
    password: 'password',
    password_confirmation: 'password'
  )
end
