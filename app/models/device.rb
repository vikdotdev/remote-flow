class Device < ApplicationRecord
  belongs_to :organization
  has_and_belongs_to_many :device_groups

  validates :name, presence: true, allow_blank: false, length: { maximum: 255 }

  scope :by_name, -> { order(:name) }
end
