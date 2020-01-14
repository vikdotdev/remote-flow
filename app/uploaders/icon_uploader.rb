class IconUploader < CarrierWave::Uploader::Base
  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url(*)
    'default_channel_icon.svg'
  end

  def extension_whitelist
    %w[svg]
  end
end
