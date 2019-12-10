class Presentation < Content
  validates :file, presence: true

  mount_uploader :file, PresentationUploader
end
