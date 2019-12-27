require 'rails_helper'

RSpec.describe Notification, type: :model do
  describe 'factory specs' do
    it 'has factory' do
      expect(build(:notification)).to be_valid
    end
  end
end
