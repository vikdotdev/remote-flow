class Organization < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :device_groups, dependent: :destroy
  has_many :channels, dependent: :destroy

  validates :name, presence: true,
                   uniqueness: true
end
