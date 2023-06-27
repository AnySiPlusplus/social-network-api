FactoryBot.define do
  factory :news do
    content { FFaker::Lorem.characters(20) }
    file { nil }
    user { create(:user) }
  end
end
