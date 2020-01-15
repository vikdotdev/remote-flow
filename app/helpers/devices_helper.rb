module DevicesHelper
  def icon(path)
    path = 'fallback/default_channel_icon.svg' if path.blank?
    image_tag asset_path(path)
  end
end
