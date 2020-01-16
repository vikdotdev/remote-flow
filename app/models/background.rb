class Background < ApplicationRecord
  mount_uploader :image, BackgroundUploader

  validates :image, presence: true
  belongs_to :organization
end
