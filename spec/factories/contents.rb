FactoryBot.define do
  factory :content, class: 'Content' do
    title { Faker::Company.industry }
    organization

    trait :video do
      type { 'Video' }
      video_url { Faker::Internet.url }
    end

    trait :gallery do
      type { 'Gallery' }
      video_url { Faker::Internet.url }
    end

    factory :gallery, class: 'Gallery', traits: [:gallery]
    factory :video, class: 'Video', traits: [:video]
  end
end
