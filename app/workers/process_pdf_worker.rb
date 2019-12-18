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
      path = Rails.root.join("tmp/storage/#{presentation.file.identifier}-#{i}.png")
      image.write(path) do
        self.quality = 100
      end

      Screenshot.create!(presentation: presentation, file: path.open)

      File.delete(path) if File.exist?(path)
    end
  end
end
