class TelegramBotController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext

  def start!(*)
    respond_with :message, text: 'Hi. Entry you /email exmple@mail.com and /password exepmle'
  end

  def email!(email)
    respond_with :message, text: email
    session['email'] = 'Success'
  end

  def password!(password)
    session['password'] = password
    if user_valid?
      respond_with :message, text: 'Success'
    else
      respond_with :message, text: 'Not valid email or password'
    end
  end

  def channels!
    if user_valid?
      channels = user.organization.channels.pluck(:name).join("\n")
      respond_with :message, text: channels
    else
      respond_with :message, text: 'Not valid email or password'
    end
  end

  private

  def user_valid?
    User.find_by(email: session['email']).valid_password?(session['password'])
  end

  def user
    return unless user_valid?
    User.find_by(email: session['email'])
  end
end
