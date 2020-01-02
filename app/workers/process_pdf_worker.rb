class ProcessPdfWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(id, density = '300x300')
    @presentation = Presentation.find(id)
    images = -> { Magick::Image.read(@presentation.file.path) }

    hi_res_images = images.call { self.quality = 100; self.density = density }
    low_res_images = images.call { self.size = 0.2 }

    write_images(hi_res_images)
    write_images(low_res_images, :low)
  end

  private

  def write_images(images, quality = :high)
    images.each_with_index do |image, i|
      temp = Tempfile.new(["#{@presentation.file.identifier}-#{i}-#{quality}", '.png'])

      image.write("png:#{temp.path}") { self.quality = 100 }
      Screenshot.create!(presentation: @presentation, file: temp.open, quality: quality)

      temp.close
      temp.unlink
    end
  end
end
