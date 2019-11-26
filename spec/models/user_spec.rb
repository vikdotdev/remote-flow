require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'factory specs' do
    let!(:user) { create(:user) }

    it 'has factory' do
      expect(user).to be_persisted
    end
  end

  describe 'validation specs' do
    it 'has invalid email' do
      expect(build(:user, email: 'some_not_valid_email')).not_to be_valid
    end

    it 'has valid email' do
      expect(build(:user, email: 'some@valid.em')).to be_valid
    end
  end

end
