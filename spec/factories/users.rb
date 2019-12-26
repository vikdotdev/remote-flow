FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    password { 'passwd' }
    password_confirmation { 'passwd' }
    role { User::ADMIN }
    organization

    trait :with_avatar do
      avatar { Rack::Test::UploadedFile.new(Rails.root + "spec/files/#{rand(10)}.jpg", 'image/jpeg') }
    end

    trait :super_admin do
      role { User::SUPER_ADMIN }
    end

    trait :admin do
      role { User::ADMIN }
    end

    trait :manager do
      role { User::MANAGER }
    end

    factory :super_admin, traits: [:super_admin]
    factory :admin, traits: [:admin]
    factory :manager, traits: [:manager]
  end
end
