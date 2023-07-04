FactoryBot.define do
  factory :friend do
    user { create(:user) }
  end
end
