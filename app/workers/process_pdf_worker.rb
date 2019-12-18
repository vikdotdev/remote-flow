class ProcessPdfWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(id)
    presentation = Presentation.find(id)
    images = Magick::Image.read(presentation.file.path) do
      self.quality = 100
      self.density = '300x300'
    end

    images.each_with_index do |image, i|
      temp = Tempfile.new(["#{presentation.file.identifier}-#{i}", '.png'])
      image.write("png:#{temp.path}") { self.quality = 100 }
      Screenshot.create!(presentation: presentation, file: temp.open)

      temp.close
      temp.unlink
    end
  end
end
