FactoryBot.define do
  factory :device_group do
    name { Faker::Address.city }
    organization
  end
end
