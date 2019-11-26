FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    password { 'passwd' }
    role { 'admin' }
    organization

    trait :with_avatar do
      avatar { Rack::Test::UploadedFile.new(Rails.root + "spec/files/#{rand(10)}.jpg", 'image/jpeg') }
    end
  end
end
