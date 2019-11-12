require 'rails_helper'

RSpec.describe Gallery, type: :model do
  describe 'factory spec' do
    let!(:gallery) { create(:gallery) }

    it 'Gallery model has factories' do
      expect(gallery).to be_persisted
    end
  end
end
