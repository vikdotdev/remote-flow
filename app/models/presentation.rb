class Presentation < Content
  mount_uploader :file, PresentationUploader

  has_many :screenshots, dependent: :destroy

  validates :file, presence: true

  after_create :generate_previews
  after_create :parse_pdf

  private

  def generate_previews
    ProcessPdfWorker.perform_async(id)
  end

  def parse_pdf
    ParsePdfWorker.perform_async(id)
  end
end
