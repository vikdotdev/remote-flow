class Presentation < Content
  include Searchable
  
  mount_uploader :file, PresentationUploader

  has_many :screenshots, dependent: :destroy

  validates :file, presence: true

  after_create :generate_previews

  private

  def generate_previews
    ProcessPdfWorker.perform_async(id)
  end
end
