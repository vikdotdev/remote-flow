class Gallery < Content
  has_many :gallery_images, dependent: :destroy
end
