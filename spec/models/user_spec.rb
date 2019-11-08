require 'rails_helper'

RSpec.describe User, type: :model do
  context 'factory tests' do
    let!(:organization) { create(:organization) }

    it 'has factory' do
      expect(create(:user, organization_id: organization.id)).to be_persisted
    end
  end
end
