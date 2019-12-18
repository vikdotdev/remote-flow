class Screenshot < ApplicationRecord
  mount_uploader :file, ScreenshotUploader

  validates :file, presence: true

  belongs_to :presentation
end
