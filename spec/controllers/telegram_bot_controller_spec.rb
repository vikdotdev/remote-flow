require 'rails_helper'
require 'telegram/bot/updates_controller/rspec_helpers'

RSpec.describe TelegramBotController, type: :telegram_bot_controller do
  let!(:organization) { create(:organization) }
  let!(:user) { create(:user, organization: organization) }
  let!(:channels) { create_list(:channel, 5, organization: organization) }


  describe '#start' do
    it 'return response' do
      expect{ dispatch_command :start }.to respond_with_message 'Hi. Entry you /email exmple@mail.com and /password exepmle'
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
      it 'save password in session' do
        dispatch_command :email, user.email

        expect{ dispatch_command :password, user.password }.to respond_with_message 'Success'
        expect(session['password']).to eq(user.password)
      end
    end

    context 'when password is not valid' do
      it 'save password in session ' do
        dispatch_command :email, user.email

        expect{ dispatch_command :password, '123456' }.to respond_with_message 'Not valid email or password'
        expect(session['password']).not_to eq(user.password)
      end
    end
  end

  describe '#channels' do
    context 'when valid' do
      it 'return list of channels' do
        dispatch_command :email, user.email
        dispatch_command :password, user.password

        expect{ dispatch_command :channels }.to respond_with_message channels.pluck(:name).join("\n")
      end
    end

    context 'when not valid' do
      it 'return message error' do
        dispatch_command :email, 'email@mail.com'
        dispatch_command :password, '123456'

        expect{ dispatch_command :channels }.to respond_with_message 'Not valid email or password'
      end
    end
  end
end
