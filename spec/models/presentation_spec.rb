require 'rails_helper'

RSpec.describe Presentation, type: :model do
  describe 'factory spec' do
    let!(:presentation) { create(:content, :presentation) }

    it 'Presentation model has factories' do
      expect(presentation).to be_persisted
    end
  end
end
