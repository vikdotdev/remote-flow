class Background < ApplicationRecord
  mount_uploader :image, BackgroundUploader

  belongs_to :organization

  validates :image, presence: true
end
