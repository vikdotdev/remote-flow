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

  trait :with_contents do
    contents do
      [
        create(:video, organization: self.organization),
        create(:gallery, organization: self.organization),
        create(:page, organization: self.organization)
      ]
    end
  end
end
