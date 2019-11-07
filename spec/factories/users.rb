FactoryBot.define do
  factory :organization do
    name { Faker::Internet.name }
    logo { Faker::Internet.name }
  end
  factory :user do
    email { Faker::Internet.email }
    first_name { Faker::Name.name }
    role { 'admin' }
    organization_id { 1 }
  end
end
