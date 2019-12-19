require 'rails_helper'

RSpec.describe Screenshot, type: :model do
  describe 'factory spec' do
    let!(:screenshot) { create(:screenshot) }

    it 'has factories' do
      expect(screenshot).to be_persisted
    end
  end
end
