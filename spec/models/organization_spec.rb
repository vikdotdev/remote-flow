require 'rails_helper'

RSpec.describe Organization, type: :model do
  describe 'factory specs' do
    let!(:organization) { create(:organization) }

    it 'has factory' do
      expect(organization).to be_persisted
    end
  end
end
