require 'factory_bot_rails'
require 'faker'

organization_count = 3
organization_count.times do
  FactoryBot.create(:organization)
end

user_count = (1..9)
user_count.each do |n|
  # maps 3 users to each organization
  FactoryBot.create(:user, organization_id: (n % organization_count) + 1)
end

