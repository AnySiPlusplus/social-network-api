FactoryBot.define do
  factory :user do
    login { FFaker::Internet.email }
    password { FFaker::Internet.password }
    password_confirmation { password }
  end
end
