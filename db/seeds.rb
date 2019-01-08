# frozen_string_literal: true

User.create(
  email: 'ryto.verkar@gmail.com',
  password: 'password',
  password_confirmation: 'password',
  profile_attributes: {
    first_name: "Ryto",
    last_name: "Verkar",
    birthday: Faker::Date.birthday,
    gender: "male",
    bio: Faker::Lorem.paragraph(2)
  }
)

50.times do
  User.create(
    email: Faker::Internet.email,
    password: 'password',
    password_confirmation: 'password',
    profile_attributes: {
      first_name: Faker::Name.male_first_name,
      last_name: Faker::Name.last_name,
      birthday: Faker::Date.birthday,
      gender: "male",
      bio: Faker::Lorem.paragraph(2)
    }
  )
end

50.times do
  User.create(
    email: Faker::Internet.email,
    password: 'password',
    password_confirmation: 'password',
    profile_attributes: {
      first_name: Faker::Name.female_first_name,
      last_name: Faker::Name.last_name,
      birthday: Faker::Date.birthday,
      gender: "female",
      bio: Faker::Lorem.paragraph(2)
    }
  )
end
