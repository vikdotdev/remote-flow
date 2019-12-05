require 'rails_helper'

RSpec.describe GalleryImage, type: :model do
  let!(:gallery_image) { create(:gallery_image) }

  describe 'factory spec' do
    it 'has factory' do
      expect(gallery_image).to be_persisted
    end
  end
end
