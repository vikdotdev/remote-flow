class Device < ApplicationRecord
  belongs_to :organization
  has_and_belongs_to_many :device_groups

  validates :name, presence: true, length: { maximum: 255 }
end
