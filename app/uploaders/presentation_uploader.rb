class PresentationUploader < CarrierWave::Uploader::Base
  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_whitelist
    %w(pdf pptx)
  end

  def default_url(*args)
    # For Rails 3.1+ asset pipeline compatibility:
    ActionController::Base.helpers.asset_path("fallback/logo/" + [version_name,
        "default.pdf"].compact.join('_'))
  end

end
