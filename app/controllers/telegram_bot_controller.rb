class TelegramBotController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext
  def start!(*)
    respond_with :message, text: 'Hi. Entry you /email exmple@mail.com and /password exepmle'
  end

  def email!(email)
    respond_with :message, text: 'Success'
    session['email'] = email
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
      respond_with :message, text: channels.pluck(:name).join("\n")
    else
      respond_with :message, text: 'Not valid email or password'
    end
  end

  private

  def user_valid?
    user = User.find_by(email: session['email'])
    return if user.nil?
    user.valid_password?(session['password'])
  end

  def channels
    return unless user_valid?
    User.find_by(email: session['email']).organization.channels
  end
end
