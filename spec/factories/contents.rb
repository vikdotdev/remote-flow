FactoryBot.define do
  factory :content_of_video, class: 'Content' do
    type { 'Video' }
    video_url { Faker::Internet.url }
  end
  factory :content_of_gallery, class: 'Video' do
    type { 'Gallery' }
    video_url { Faker::Internet.url }
  end
end
