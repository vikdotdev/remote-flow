FactoryBot.define do
  factory :channel do
    name { Faker::App.name }
    organization
    icon do
      Rack::Test::UploadedFile.new(
        Rails.root + 'vendor/assets/images/default_channel_icon.svg',
        'image/svg'
      )
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
