FactoryBot.define do
  factory :background do
    image do
      ActionController::Base.helpers.asset_url(
        "backgrounds/#{File.basename(Dir.glob("app/assets/images/backgrounds/*.jpg").sample)}"
      )
    end
    organization
  end
end
