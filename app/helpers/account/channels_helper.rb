module Account::ChannelsHelper
  def channel_icons
    images_path = Pathname.new('vendor/assets/images')

    Dir.glob("vendor/assets/images/channel_icons/*.svg").map do |img_path|
      {
        id: asset_path(Pathname.new(img_path).relative_path_from(images_path)),
        text: File.basename(img_path, ".*").humanize,
        icon: asset_path(Pathname.new(img_path).relative_path_from(images_path))
      }
    end
  end
end
