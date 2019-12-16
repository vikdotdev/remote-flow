class Presentation < Content
  after_create :generate_previews
  validates :file, presence: true

  mount_uploader :file, PresentationUploader

  private

  def generate_previews
    ProcessPdfWorker.perform_in(Time.now)
  end
end
