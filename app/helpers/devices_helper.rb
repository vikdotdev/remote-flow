module DevicesHelper
  def icon(path)
    if path
      File.open(path) { |file| raw file.read }
    else
      File.open(Rails.root.join('vendor/assets/images/default_channel_icon.svg')) { |file| raw file.read }
    end
  end
end
