class Background < ApplicationRecord
  validates :image, presence: true

  belongs_to :organization
end
