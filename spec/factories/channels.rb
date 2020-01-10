FactoryBot.define do
  factory :channel do
    name { Faker::App.name }
    organization

    trait :with_icon do
      icon do
        Rack::Test::UploadedFile.new(
          Rails.root + 'vendor/assets/images/device_icons/default.svg',
          'image/svg'
        )
      end
    end
  end
end
