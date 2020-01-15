module Account::ChannelsHelper
  def channel_icons
    Dir.glob("app/assets/images/channel_icons/*.svg").map do |icon_path|
      [
        File.basename(icon_path, ".*").humanize,
        asset_path("channel_icons/#{File.basename(icon_path)}")
      ]
    end
  end
end
