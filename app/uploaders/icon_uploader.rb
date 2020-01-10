class IconUploader < CarrierWave::Uploader::Base
  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url(*args)
    'images/device_icons/default.svg'
  end

  def extension_whitelist
    %w[svg]
  end
end
