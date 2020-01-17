class TelegramBotController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext
  def start!(*)
    respond_with :message, text: 'Hi. Entry your /email example@mail.com and then /password example'
  end

  def email!(email)
    respond_with :message, text: 'Success'
    session['email'] = email
  end

  def password!(password)
    session['password'] = password
    if telegram_user?
      respond_with :message, text: 'Success. Entry /channels to see all channels'
    else
      respond_with :message, text: 'Not found'
    end
  end

  def channels!
    if telegram_user?
      respond_with :message, text: channels.pluck(:name).join("\n")
    else
      respond_with :message, text: 'Not found'
    end
  end

  private

  def telegram_user?
    telegram_user&.valid_password?(session['password'])
  end

  def telegram_user
    @telegram_user  = User.find_by(email: session['email'])
  end

  def channels
    if telegram_user.super_admin?
      Channel.all
    else
      telegram_user.organization.channels
    end
  end
end
