FactoryBot.define do
  factory :organization do
    name { Faker::Company.name }
    logo { Faker::Internet.url }
  end
end

