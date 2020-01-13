require 'rails_helper'
require 'telegram/bot/updates_controller/rspec_helpers'

RSpec.describe TelegramBotController, telegram_bot: :rails do
  describe '#start' do
    it 'response return' do
      expect{ dispatch_command :start }.to respond_with_message 'Hi. Entry you /email exemple@mail.com and /password exemple'
      debugger
    end
  end
end
