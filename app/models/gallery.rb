class Gallery < Content
  include Searchable
  
  has_many :gallery_images, dependent: :destroy
end
