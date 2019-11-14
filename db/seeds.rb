require 'factory_bot_rails'
require 'faker'

3.times do
  organization = FactoryBot.create(:organization)

  users = FactoryBot.create_list(:user, 10, organization_id: organization.id)
  devices = FactoryBot.create_list(:device, 20, organization_id: organization.id)
  device_groups = FactoryBot.create_list(:device_group, 10, organization_id: organization.id)
  channels = FactoryBot.create_list(:channel, 10, organization_id: organization.id)

  device_groups.each do |device_group|
    rand(2..6).times do
      device = devices[rand(0..19)]
      device_group.devices << device unless device_group.devices.include? device
    end
  end
end
