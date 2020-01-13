require 'rails_helper'
require 'digest'

RSpec.describe Device, type: :model do
  describe 'factory specs' do
    let!(:device) { create(:device, :with_channels) }

    it 'has factory' do
      expect(device).to be_persisted
    end

    it 'has channels through organization' do
      expect(device.organization.channels.count).to eq(3)
    end
  end

  describe 'validation specs' do
    it 'has invalid name' do
      expect(build(:device, name: '')).not_to be_valid
    end

    it 'has valid name' do
      expect(build(:device, name: 'some_device')).to be_valid
    end
  end
end
