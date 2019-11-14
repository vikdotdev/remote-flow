FactoryBot.define do
  factory :content, class: 'Content' do

    organization

    trait :video do
      type { 'Video' }
      video_url { 'https://www.youtube.com/watch?v=IWZ_71EKbng&t=5s' }
    end

    trait :gallery do
      type { 'Gallery' }
      video_url { Faker::Internet.url }
    end
  end
end
