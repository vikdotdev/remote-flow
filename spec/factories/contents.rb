FactoryBot.define do
  factory :content, class: 'Content' do
    title { Faker::Company.industry }
    organization

    trait :video do
      type { 'Video' }
      video_url { 'https://www.youtube.com/watch?v=Gzj723LkRJY' }
    end

    trait :gallery do
      type { 'Gallery' }
    end

    trait :presentation do
      type { 'Presentation' }
      file { Rack::Test::UploadedFile.new(Rails.root + "spec/files/example.pdf", 'application/pdf') }
    end

    factory :gallery, class: 'Gallery', traits: [:gallery]
    factory :video, class: 'Video', traits: [:video]
    factory :presentation, class: 'Presentation', traits: [:presentation]
  end
end
