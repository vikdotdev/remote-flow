require 'rails_helper'

RSpec.describe Channel, type: :model do
  describe 'factory spec' do
    let!(:channel) { create(:channel) }

    it 'has factory' do
      expect(channel).to be_persisted
    end
  end
end
