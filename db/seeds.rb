require 'factory_bot_rails'
require 'faker'

FactoryBot.create(:user, organization_id:  nil, role: 'super_admin')

3.times do
  organization = FactoryBot.create(:organization)

  FactoryBot.create_list(:user, 10, :with_avatar, organization_id: organization.id)
  devices = FactoryBot.create_list(:device, 20, organization_id: organization.id)
  device_groups = FactoryBot.create_list(:device_group, 10, organization_id: organization.id)
  channels = FactoryBot.create_list(:channel, 10, organization_id: organization.id)
  content_with_gallery = FactoryBot.create_list(:content, 5, :gallery, organization_id: organization.id)
  content_with_video = FactoryBot.create_list(:content, 5, :video, organization_id: organization.id)

  device_groups.each do |device_group|
    rand(2..6).times do
      device = devices[rand(0..19)]
      device_group.devices << device unless device_group.devices.include? device
    end
  end

  channels.each do |channel|
    rand(0..3).times do
      content = content_with_gallery.sample
      channel.contents << content unless channel.contents.include? content
    end

    rand(0..3).times do
      content = content_with_video.sample
      channel.contents << content unless channel.contents.include? content
    end
  end
end
