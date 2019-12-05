require 'rails_helper'

RSpec.describe Content, type: :model do
  let!(:content) { create(:content) }

  describe 'factory specs' do
    it 'has factory' do
      expect(content).to be_persisted
    end
  end

  describe 'validation specs' do
    it 'has invalid title' do
      expect(build(:content, title: '')).not_to be_valid
    end

    it 'has valid title' do
      expect(build(:content, title: 'my_content')).to be_valid
    end
  end
end
