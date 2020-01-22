module DevicesHelper
  def icon(path)
    path = 'fallback/default_channel_icon.svg' if path.blank?
    image_tag asset_path(path)
  end

  def random_background(device)
    bg = device.organization.backgrounds.order('random()').limit(1)
    asset_path(bg.first&.image ? bg.first.image : '')
  end
end
