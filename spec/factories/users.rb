FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    role { 'admin' }
    # organization_id is overwritten in seeds.rb
    organization_id { 1 }
  end
end
