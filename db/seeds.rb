require 'factory_bot_rails'
require 'faker'

organization = FactoryBot.create(:organization)
# device_group = FactoryBot.create(:device_group)

3.times do
  FactoryBot.create(:user, organization_id: organization.id)
  FactoryBot.create(:device,
    # device_group: device_group,
    organization: organization
  )
end

