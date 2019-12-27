FactoryBot.define do
  factory :feedback do
    email { Faker::Internet.email }
    name { Faker::Name.name }
    message { Faker::Lorem.paragraph_by_chars }
  end
end
