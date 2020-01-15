module DevicesHelper
  def icon(path)
    path ||= '/assets/images/default_channel_icon.svg'
    raw File.read(Rails.root.join('public').to_s + path)
  end
end
