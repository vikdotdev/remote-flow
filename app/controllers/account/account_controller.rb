class Account::AccountController < ApplicationController
  layout 'account'

  before_action :authenticate_user!

  def current_organization
    current_user.organization
  end

  private

  def notification
    @notifications = current_user.notifications.order(id: :desc)
    @read_notifications = current_user.notifications.where(read: true)
    @unread_notificaitons = current_user.notifications.where(read: false)
  end
end

