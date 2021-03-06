require 'factory_bot_rails'
require 'faker'

super_administrator = FactoryBot.create(:user, organization_id: nil, role: 'super_admin')

3.times do
  organization = FactoryBot.create(:organization)

  users = FactoryBot.create_list(:user, 10, :with_avatar, organization_id: organization.id)
  devices = FactoryBot.create_list(:device, 20, organization_id: organization.id)
  device_groups = FactoryBot.create_list(:device_group, 10, organization_id: organization.id)
  channels = FactoryBot.create_list(:channel, 10, organization_id: organization.id)
  content_with_gallery = FactoryBot.create_list(:content, 5, :gallery, organization_id: organization.id)
  content_with_video = FactoryBot.create_list(:content, 5, :video, organization_id: organization.id)
  content_with_presentation = FactoryBot.create_list(:presentation_with_screenshots, 5, organization_id: organization.id)
  content_with_page = FactoryBot.create_list(:content, 5, :page, organization_id: organization.id)
  feedbacks = FactoryBot.create_list(:feedback, 5)
  backgrounds = FactoryBot.create_list(:background, 5, organization: organization)

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

    rand(0..3).times do
      content = content_with_presentation.sample
      channel.contents << content unless channel.contents.include? content
    end

    rand(0..3).times do
      content = content_with_page.sample
      channel.contents << content unless channel.contents.include? content
    end
  end

  users.each do |user|
    rand(0..3).times do
      FactoryBot.create(:invite, organization_id: organization.id, sender: user)
    end
  end
end
