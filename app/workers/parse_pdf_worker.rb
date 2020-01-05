class ParsePdfWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(id)
    presentation = Presentation.find(id)
    pdf_text = ''
    pdf_file = PDF::Reader.new(presentation.file.path)

    pdf_file.pages.each do |page|
      pdf_text += page.text
    end

    presentation.update(presentation_body_plain: pdf_text.to_s)
  end
end
