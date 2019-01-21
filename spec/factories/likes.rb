FactoryBot.define do
  factory :post_like, class: "Like" do
    likeable_id { 1 }
    likeable_type { "Post" }
    liker_id { 1 }
  end

  factory :comment_like, class: "Like" do
    likeable_id { 1 }
    likeable_type { "Comment" }
    liker_id { 1 }
  end
end
