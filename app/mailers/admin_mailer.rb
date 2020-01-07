class AdminMailer < ApplicationMailer
  default from: 'remote-flow@mail.com'

  def delete_channel(channel)
    @channel = channel
    mail(to: channel.organization.users.admins.pluck(:email), subject: 'Channel was deleted') unless channel.organization.users.admins.empty?
  end
end
