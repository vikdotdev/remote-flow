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

    trait :with_channels do
      after(:create) do |device|
        create_list(:channel, 3, organization: device.organization)
      end
    end
  end
end
