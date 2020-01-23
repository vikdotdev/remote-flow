class BackgroundUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  version :thumb do
    process resize_to_fill: [300, 300]
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url(*)
    'images/fallback'
  end

  def extension_whitelist
    %w[jpg jpeg png]
  end
end
