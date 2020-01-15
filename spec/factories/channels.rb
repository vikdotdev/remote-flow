FactoryBot.define do
  factory :channel do
    name { Faker::App.name }
    organization
    icon { 'fallback/default_channel_icon.svg' }
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
