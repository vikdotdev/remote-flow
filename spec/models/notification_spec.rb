require 'rails_helper'

RSpec.describe Notification, type: :model do
  let!(:notification) { create(:notification) }

  describe 'factory specs' do
    it 'has factory' do
      expect(notification).to be_persisted
    end
  end
end
