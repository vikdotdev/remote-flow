class Screenshot < ApplicationRecord
  mount_uploader :file, ScreenshotUploader

  belongs_to :presentation

  validates :file, presence: true
end
