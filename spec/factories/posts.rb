FactoryBot.define do
  factory :timeline_post, class: "Post" do
    user_id { 1 }
    timeline_id { 1 }
    body { Faker::Lorem.paragraph(5) }
  end

  factory :newsfeed_post, class: "Post" do
    user_id { 1 }
    timeline_id { 1 }
    body { Faker::Lorem.paragraph(5) }
  end
end
