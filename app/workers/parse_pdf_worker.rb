class ParsePdfWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(id)
    presentation = Presentation.find(id)
    pdf_file = PDF::Reader.new(presentation.file.path)
    pdf_text = pdf_file.pages.collect(&:text).join("\n")

    presentation.update(presentation_body_plain: pdf_text)
  end
end
