class Channel < ApplicationRecord
  belongs_to :organization
  has_and_belongs_to_many :device_groups
  has_and_belongs_to_many :contents

  validates :name, presence: true,
                   length: { minimum: 2,
                             maximum: 255 }
end
