FactoryBot.define do
  factory :post_like, class: "Like" do
    likeable_id { 1 }
    likeable_type { "Post" }
    liker { 1 }
  end

  factory :comment_like, class: "Like" do
    likeable_id { 1 }
    likeable_type { "Comment" }
    liker { 1 }
  end
end
