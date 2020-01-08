require 'active_support/concern'

module Notify
  extend ActiveSupport::Concern

  def notify_created!
    case self.class.name
    when 'User'
      notification_type = Notification::USER_ADDED
    when 'Organization'
      notification_type = Notification::ORGANIZATION_CREATED
    end

    User.super_admins.each do |super_admin|
      super_admin.notifications.create(notification_type: notification_type, notificable: self)
    end
  end

  def notify_deleted!
    case self.class.name
    when 'User'
      notification_type = Notification::USER_DELETED
    when 'Organization'
      notification_type = Notification::ORGANIZATION_DELETED
    end
    User.super_admins.each do |super_admin|
      super_admin.notifications.create(notification_type: notification_type, notificable: self)
    end
  end
end