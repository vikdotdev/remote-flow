class Screenshot < ApplicationRecord
  HIGH = 'high'.freeze
  LOW = 'low'.freeze

  mount_uploader :file, ScreenshotUploader

  belongs_to :presentation

  validates :file, presence: true
  validates :quality, presence: true, inclusion: [HIGH, LOW]

  scope :high_only, -> { where(quality: HIGH) }
  scope :low_only, -> { where(quality: LOW) }
end
