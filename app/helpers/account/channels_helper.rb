module Account::ChannelsHelper
  def system_icons
    Dir.glob(Rails.root.join('vendor', 'assets', 'images', 'channel_icons', '**/*')).map do |img_path|
      {
        id: img_path,
        text: File.basename(img_path, ".*").humanize,
        icon: asset_url(img_path)
      }
    end
  end
end
