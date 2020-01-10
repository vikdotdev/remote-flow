class AdminMailer < ApplicationMailer
  default from: 'remote-flow@mail.com'

  def delete_channel(channel)
    return unless channel.organization.users.admins.any?
    @channel = channel
    mail(to: channel.organization.users.admins.pluck(:email), subject: 'Channel was deleted')
  end
end
