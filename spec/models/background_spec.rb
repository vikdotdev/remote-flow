require 'rails_helper'

RSpec.describe Background, type: :model do
  let!(:background) { create(:background) }

  describe 'factory specs' do
    it 'has factory' do
      expect(background).to be_persisted
    end
  end

  describe 'validation specs' do
    it 'has image' do
      expect(background.image).not_to be_nil
    end
  end
end
