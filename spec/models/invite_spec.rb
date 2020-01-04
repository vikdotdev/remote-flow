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

    it 'has invalid role' do
      invite.role = ''
      expect(invite).not_to be_valid
    end

    it 'has valid role' do
      expect(invite).to be_valid
    end

    describe 'has unique email per organization' do
      EMAIL = 'example@email.com'
      let!(:organization) { create(:organization) }
      let!(:another_organization) { create(:organization) }
      let!(:second_invite) { build(:invite, email: EMAIL, organization: organization) }
      let!(:third_invite) { build(:invite, email: EMAIL, organization: organization) }

      it 'cannot have identical invite emails in one organization' do
        second_invite.save
        third_invite.save
        expect(third_invite).not_to be_persisted
      end

      it 'can have identical emails in different organizations' do
        second_invite.organization = another_organization
        second_invite.save
        third_invite.save
        expect(third_invite).to be_persisted
      end
    end
  end
end
