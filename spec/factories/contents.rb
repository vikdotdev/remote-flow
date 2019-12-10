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
      page_title { Faker::Company.industry }
      page_body { Faker::Lorem.paragraphs(number: 4).join}
    end

    factory :gallery, class: 'Gallery', traits: [:gallery]
    factory :video, class: 'Video', traits: [:video]
    factory :page, class: 'Page', traits: [:page]
  end
end
