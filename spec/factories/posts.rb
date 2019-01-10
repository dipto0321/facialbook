FactoryBot.define do
  factory :timeline_post, class: "Post" do
    user_id { 1 }
    postable_id { 1 }
    postable_type { "Timeline" }
    body { Faker::Lorem.paragraph(5) }
  end

  factory :newsfeed_post, class: "Post" do
    user_id { 1 }
    postable_id { 1 }
    postable_type { "Newsfeed" }
    body { Faker::Lorem.paragraph(5) }
  end
end
