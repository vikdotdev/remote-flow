FactoryBot.define do
  factory :video do
    type { 'Video' }
    video_url { Faker::Internet.url }
  end
end
