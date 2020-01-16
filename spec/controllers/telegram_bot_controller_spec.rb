require 'rails_helper'
require 'telegram/bot/updates_controller/rspec_helpers'

RSpec.describe TelegramBotController, type: :telegram_bot_controller do
  let!(:organization) { create(:organization) }
  let!(:user) { create(:user, organization: organization) }
  let!(:super_admin) { create(:user, :super_admin) }
  let!(:channels) { create_list(:channel, 5, organization: organization) }

  describe '#start' do
    it 'return response' do
      expect{ dispatch_command :start }.to respond_with_message 'Hi. Entry your /email example@mail.com and then /password example'
    end
  end

  describe '#email' do
    it 'save email in session' do
      expect{ dispatch_command :email, user.email }.to respond_with_message 'Success'
      expect(session['email']).to eq(user.email)
    end
  end


  describe '#password' do
    context 'when password is valid' do
      it 'returns the message of success' do
        dispatch_command :email, user.email

        expect{ dispatch_command :password, user.password }.to respond_with_message 'Success. Entry /channels to see all channels'
        expect(session['password']).to eq(user.password)
      end
    end

    context 'when password is not valid' do
      it 'return a failure message' do
        dispatch_command :email, user.email

        expect{ dispatch_command :password, '123456' }.to respond_with_message 'Not valid email or password'
        expect(session['password']).not_to eq(user.password)
      end
    end
  end

  context 'when user is admin' do
    describe '#channels' do
      context 'when valid' do
        it 'return list of channels' do
          dispatch_command :email, user.email
          dispatch_command :password, user.password

          expect{ dispatch_command :channels }.to respond_with_message channels.pluck(:name).join("\n")
        end
      end

      context 'when not valid' do
        it 'return a failure message' do
          dispatch_command :email, 'email@mail.com'
          dispatch_command :password, '123456'

          expect{ dispatch_command :channels }.to respond_with_message 'Not valid email or password'
        end
      end
    end
  end

  context 'when user is super_admin' do
    describe '#channels' do
      context 'when valid' do
        it 'return list of all channels' do
          create_list(:channel, 5)

          dispatch_command :email, super_admin.email
          dispatch_command :password, super_admin.password

          expect{ dispatch_command :channels }.to respond_with_message Channel.all.pluck(:name).join("\n")
        end
      end

      context 'when not valid' do
        it 'return a failure message' do
          dispatch_command :email, 'email@mail.com'
          dispatch_command :password, '123456'

          expect{ dispatch_command :channels }.to respond_with_message 'Not valid email or password'
        end
      end
    end
  end
end
