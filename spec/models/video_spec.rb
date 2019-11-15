require 'rails_helper'

RSpec.describe Video, type: :model do
  describe 'factory spec' do
    let!(:video) { create(:content, :video) }

    it 'Video model has factories' do
      expect(video).to be_persisted
    end
  end
end
