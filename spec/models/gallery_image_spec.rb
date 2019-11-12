require 'rails_helper'

RSpec.describe GalleryImage, type: :model do
  describe 'factory spec' do
    let(:gallery_image) { create(:gallery_image) }

    it 'GalleryImage model has factories' do
      expect(gallery_image).to be_persisted
    end
  end
end
