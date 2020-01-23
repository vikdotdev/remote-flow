module DevicesHelper
  def icon(path)
    path = 'fallback/default_channel_icon.svg' if path.blank?
    image_tag asset_path(path)
  end

  def random_background(device)
    bg = device.organization.backgrounds.order('random()').take
    bg ? asset_path(bg.image) : ''
  end
end
