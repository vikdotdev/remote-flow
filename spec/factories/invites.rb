FactoryBot.define do
  factory :invite do
    email { Faker::Internet.email }
    role { User::ADMIN }
    organization

    association :sender, factory: :user
  end
end
