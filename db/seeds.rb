# frozen_string_literal: true

User.create(
  email: 'ryto.verkar@gmail.com',
  password: 'password',
  password_confirmation: 'password',
  profile_attributes: {
    first_name: 'Ryto',
    last_name: 'Verkar',
    birthday: Faker::Date.birthday,
    gender: 'male',
    bio: Faker::Lorem.paragraph(10)
  }
)

45.times do
  User.create(
    email: Faker::Internet.email,
    password: 'password',
    password_confirmation: 'password',
    profile_attributes: {
      first_name: Faker::Name.male_first_name,
      last_name: Faker::Name.last_name,
      birthday: Faker::Date.birthday,
      gender: 'male',
      bio: Faker::Lorem.paragraph(10)
    }
  )
end

45.times do
  User.create(
    email: Faker::Internet.email,
    password: 'password',
    password_confirmation: 'password',
    profile_attributes: {
      first_name: Faker::Name.female_first_name,
      last_name: Faker::Name.last_name,
      birthday: Faker::Date.birthday,
      gender: 'female',
      bio: Faker::Lorem.paragraph(10)
    }
  )
end

ryto = User.first

5.times do
  User.create(
    email: Faker::Internet.email,
    password: 'password',
    password_confirmation: 'password',
    profile_attributes: {
      first_name: Faker::Name.male_first_name,
      last_name: Faker::Name.last_name,
      birthday: Faker::Date.birthday,
      gender: 'male',
      bio: Faker::Lorem.paragraph(10)
    }
  )
  Friendship.create(
    user_id: ryto.id,
    friend_id: User.last.id
  )
end

5.times do
  User.create(
    email: Faker::Internet.email,
    password: 'password',
    password_confirmation: 'password',
    profile_attributes: {
      first_name: Faker::Name.female_first_name,
      last_name: Faker::Name.last_name,
      birthday: Faker::Date.birthday,
      gender: 'female',
      bio: Faker::Lorem.paragraph(10)
    }
  )
  Friendship.create(
    user_id: ryto.id,
    friend_id: User.last.id
  )
end

users = User.take(10)

users.each do |user|
  5.times do
    Post.create(
      author_id: User.all.sample.id,
      postable_id: user.id,
      postable_type: 'User',
      body: Faker::Lorem.paragraph(10)
    )
  end
end
