FactoryBot.define do
  factory :gallery_images, class: GalleryImage do
    image { Faker::Lorem.sentence }
  end
  
  factory :gallery_image, class: GalleryImage do
    image { Faker::Lorem.sentence }
    gallery
  end
end
