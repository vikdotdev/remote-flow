require 'rails_helper'

RSpec.describe DeviceGroup, type: :model do
  describe 'factory spec' do
    let!(:device_group) {create(:device_group) }
    
    it 'has factory' do
      expect(device_group).to be_persisted
    end
  end
end
