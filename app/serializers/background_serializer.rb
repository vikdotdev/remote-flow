class BackgroundSerializer
  include FastJsonapi::ObjectSerializer
  attribute :id

  attribute :image do |object|
    object.image.url
  end

  attribute :thumb do |object|
    object.image.thumb.url
  end
end
