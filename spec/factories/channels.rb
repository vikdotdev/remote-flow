FactoryBot.define do
  factory :channel do
    name { Faker::App.name }
    organization
    icon do
      ActionController::Base.helpers.asset_path(
        "channel_icons/#{File.basename(Dir.glob("app/assets/images/channel_icons/*.svg").sample)}"
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
