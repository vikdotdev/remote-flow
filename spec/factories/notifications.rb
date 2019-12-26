FactoryBot.define do
  factory :notification do
    body { Faker::Address.community }
    user
  end
end
