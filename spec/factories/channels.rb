FactoryBot.define do
  factory :channel do
    name { Faker::App.name }
    organization
  end
end
