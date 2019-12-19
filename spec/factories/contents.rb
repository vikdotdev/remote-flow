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

    trait :page do
      type { 'Page' }
      title { Faker::Company.industry }
      body { "<h4>#{ Faker::Lorem.sentence(word_count: 5) }</h4>" + Faker::Lorem.paragraphs(number: 4).map{|pr| "<p>#{pr}</p>" }.join + "<b>Author: #{ Faker::Name.name }<b>" }
    end

    trait :presentation do
      type { 'Presentation' }
      title { Faker::Company.industry }
      file { Rack::Test::UploadedFile.new(Rails.root + "spec/files/example.pdf") }
    end

    trait :presentation_with_screenshots do
      transient do
        screenshots_count { 5 }
      end

      after(:create) do |instance, evaluator|
        create_list(:screenshot, evaluator.screenshots_count, presentation: instance)
      end
    end

    factory :gallery, class: 'Gallery', traits: [:gallery]
    factory :video, class: 'Video', traits: [:video]
    factory :presentation, class: 'Presentation', traits: [:presentation]
    factory :presentation_with_screenshots, class: 'Presentation',
      traits: [:presentation, :presentation_with_screenshots]
    factory :page, class: 'Page', traits: [:page]
  end
end
