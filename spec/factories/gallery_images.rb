FactoryBot.define do
  factory :gallery_image, class: GalleryImage do
    image { Faker::Lorem.sentence }
    gallery
  end
end
