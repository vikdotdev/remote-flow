FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    password { 'passwd' }
    role { User::ADMIN }
    organization

    trait :super_admin do
      role { User::SUPER_ADMIN }
    end

    trait :admin do
      role { User::ADMIN }
    end

    trait :admin do
      role { User::MANAGER }
    end

    factory :super_admin, traits: [:super_admin]
  end
end
