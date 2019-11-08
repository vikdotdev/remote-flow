require 'rails_helper'

RSpec.describe Organization, type: :model do
  context 'factory tests' do
    it 'has factory' do
      expect(create(:organization)).to be_persisted
    end
  end

end
