require 'rails_helper'

RSpec.describe Invite, type: :model do
  let!(:invite) { create(:invite) }

  describe 'factory specs' do
    it 'has factory' do
      expect(invite).to be_persisted
    end
  end

  describe 'validation specs' do
    it 'has invalid email' do
      invite.email = 'invalid_email'
      expect(invite).not_to be_valid
    end

    it 'has valid email' do
      invite.email = 'valid@mail.com'
      expect(invite).to be_valid
    end

    it 'has no role' do
      invite.role = ''
      expect(invite).not_to be_valid
    end

    it 'has valid role' do
      expect(invite).to be_valid
    end
  end
end
