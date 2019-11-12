require 'rails_helper'

RSpec.describe Content, type: :model do
  describe 'factory spec' do
    let!(:content) { create(:content_of_video) }

    it 'content model has factories' do
      expect(content).to be_persisted
    end
  end
end
