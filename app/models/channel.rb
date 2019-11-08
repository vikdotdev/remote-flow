class Channel < ApplicationRecord
  belongs_to :organization
  has_and_belongs_to_many :device_groups
end
