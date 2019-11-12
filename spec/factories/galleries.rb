FactoryBot.define do
  factory :gallery do
    type { 'Gallery' }
    video_url { Faker::Internet.url }
    # gallery_images
    trait :with_gallery_images do
      after(:build) do |gallery|
        gallery.gallery_images << FactoryBot.build(:gallery_images)
      end
    end

  end
end
