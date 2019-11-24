require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:organization) { create(:organization) }
  let(:current_user) { build(:user, organization: organization) }
  let(:user) { build(:user, organization: organization) }

  before(:each) do
    user.current_user = current_user
    user.save
  end

  describe 'factory specs' do
    it 'has factory' do
      expect(user).to be_persisted
    end
  end

  describe 'validation specs' do
    it 'has invalid email' do
      user.email = 'some_not_valid_email'
      expect(user).not_to be_valid
    end

    it 'has valid email' do
      user.email = 'some@valid.em'
      expect(user).to be_valid
    end
  end
end
