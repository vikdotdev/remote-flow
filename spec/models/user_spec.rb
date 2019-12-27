require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { create(:user) }
  let!(:organization) { create(:organization) }
  let(:auth) { OmniAuth::AuthHash.new(
    info: {
      email: "jessepinkman@mountainmantechnologies.com",
      first_name: "Jesse",
      last_name: "Spevack"
    },
    credentials: {
      token: "abcdefg12345",
      refresh_token: "12345abcdefg",
    }
  )}

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

  describe 'google login' do
    it "creates or updates itself from an oauth hash" do
      user = User.from_omniauth(auth)
      user.organization_id = organization.id
      user.save
      new_user = User.last

      expect(new_user.email).to eq("jessepinkman@mountainmantechnologies.com")
      expect(new_user.first_name).to eq("Jesse")
      expect(new_user.last_name).to eq("Spevack")
      expect(new_user.google_token).to eq("abcdefg12345")
      expect(new_user.google_refresh_token).to eq("12345abcdefg")
    end
  end
end
