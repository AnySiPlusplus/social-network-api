FactoryBot.define do
  factory :message do
    user { create(:user) }
    text { FFaker::Lorem.characters(20) }
    file { nil }
    to_whom { user.id }
  end
end
