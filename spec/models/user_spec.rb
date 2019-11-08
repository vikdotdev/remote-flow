require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'factory specs' do
    let!(:user) { create(:user) }

    it 'has factory' do
      expect(user).to be_persisted
    end
  end
end
