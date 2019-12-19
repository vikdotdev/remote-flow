FactoryBot.define do
  factory :screenshot do
    file { Rack::Test::UploadedFile.new(Rails.root + "spec/files/screenshot.png") }

    presentation
  end
end
