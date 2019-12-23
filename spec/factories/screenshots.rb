FactoryBot.define do
  factory :screenshot do
    file { Rack::Test::UploadedFile.new(Rails.root + "spec/files/screenshot.png") }

    trait :with_presentation do
      presentation
    end
  end
end
