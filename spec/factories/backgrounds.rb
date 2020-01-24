FactoryBot.define do
  factory :background do
    image do
      Rack::Test::UploadedFile.new(
        Rails.root.join("app/assets/images/backgrounds/#{rand(1..5)}.jpg"),
        'image/jpeg'
      )
    end
    organization
  end
end
