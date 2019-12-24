FactoryBot.define do
  factory :organization do
    name { Faker::Company.name }
    logo { Faker::Internet.url }
    token { SecureRandom.hex(10) }
  end
end

