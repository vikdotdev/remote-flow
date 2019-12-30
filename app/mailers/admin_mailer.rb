class AdminMailer < ApplicationMailer
  default from: 'remote-flow@mail.com'

  def delete_channel_email(channel)
    @channel = channel
    mail(to: admins_email(channel.organization), subject: 'Channel was deleted')
  end

  private

  def admins_email(organization)
    organization.users.admins.pluck(:email)
  end
end
