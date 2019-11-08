class Organization < ApplicationRecord
  has_many :users
  has_many :device_groups
  has_many :channels
end
