FactoryBot.define do
  factory :content_of_video, class: 'Content' do
    type { 'Video' }
    video_url { Faker::Internet.url }
    organization
  end
  factory :content_of_gallery, class: 'Content' do
    type { 'Gallery' }
    video_url { Faker::Internet.url }
    organization
  end
end
