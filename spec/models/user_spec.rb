require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { create(:user) }
  let!(:organization) { create(:organization) }

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

  describe 'search spec' do
    it 'should update ES when the object is created' do
      User.__elasticsearch__.refresh_index!
      expect(User.search("#{user.first_name}").records.length).to eq(1)
    end

    it 'should update ES when the object is destroyed' do
      user.destroy!
      User.__elasticsearch__.refresh_index!
      expect(User.search("#{user.first_name}").records.length).to eq(0)
    end
  end

  describe '::from_omniauth' do
    context 'with existing user' do
      let!(:google_user) { create(:user, first_name: 'Jesse',
        last_name: 'Spevack', email:'jessepinkman@gmail.com', organization: organization,
        google_token: 'abcdefg12345', google_refresh_token: '12345abcdefg') }
      let(:auth_data) { OmniAuth::AuthHash.new(
        info: {
          email: google_user.email,
          first_name: google_user.first_name,
          last_name: google_user.last_name
        },
        credentials: {
          token: google_user.google_token,
          refresh_token: google_user.google_refresh_token
        }
      )}

      subject { User.from_omniauth(auth_data) }

      it { is_expected.to be_persisted }
      it { expect(subject.email).to eq('jessepinkman@gmail.com') }
      it { expect(subject.first_name).to eq('Jesse') }
      it { expect(subject.last_name).to eq('Spevack') }
      it { expect(subject.google_token).to eq('abcdefg12345') }
      it { expect(subject.google_refresh_token).to eq('12345abcdefg') }
    end

    context 'with new user' do
      let(:auth_data) { OmniAuth::AuthHash.new(
        info: {
          email: 'jessepinkman@gmail.com',
          first_name: 'Jesse',
          last_name: 'Spevack'
        },
        credentials: {
          token: 'abcdefg12345',
          refresh_token: '12345abcdefg',
        }
      )}

      subject { User.from_omniauth(auth_data) }

      it { is_expected.to be_new_record }
      it { expect(subject.email).to eq('jessepinkman@gmail.com') }
      it { expect(subject.first_name).to eq('Jesse') }
      it { expect(subject.last_name).to eq('Spevack') }
      it { expect(subject.google_token).to eq('abcdefg12345') }
      it { expect(subject.google_refresh_token).to eq('12345abcdefg') }
    end

  end
end
