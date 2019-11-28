require 'digest'

FactoryBot.define do
  factory :device do
    name { Faker::Address.city }
    token { Digest::MD5::hexdigest('my_token') }
    active { false }
    organization

    trait :active do
      active { true }
    end
  end
end
