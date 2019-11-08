require 'factory_bot_rails'
require 'faker'

organization = FactoryBot.create(:organization)

3.times do
  FactoryBot.create(:user, organization_id: organization.id)
end
