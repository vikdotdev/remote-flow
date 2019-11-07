# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
require 'factory_bot_rails'
require 'faker'

org = FactoryBot.create(:organization)
org.save
user = FactoryBot.create(:user)
user.save
#  do |user|
#   user.posts.create(FactoryBot.attributes_for(:post))
# end

