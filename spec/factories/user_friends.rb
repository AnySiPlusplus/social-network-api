FactoryBot.define do
  factory :user_friend do
    user { create(:user) }
    friend { create(:friend) }
  end
end
