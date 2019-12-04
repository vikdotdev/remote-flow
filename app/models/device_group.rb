class DeviceGroup < ApplicationRecord
  belongs_to :organization
  has_and_belongs_to_many :devices
  has_and_belongs_to_many :channels

  validates :name, presence: true,
                   length: { minimum: 2,
                             maximum: 255 }
  validates :description, length: { maximum: 255 }
end
