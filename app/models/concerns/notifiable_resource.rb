module NotifiableResource
  extend ActiveSupport::Concern

  included do
    after_create :notify_created!
    after_destroy :notify_deleted!

    private

    def notify_created!
      notify_event!(:created)
    end

    def notify_deleted!
      notify_event!(:destroyed)
    end

    def notify_event!(callback_type)
      type = Notification::RESOURCE_EVENTS[self.class.name.to_sym][callback_type.to_sym]

      people = case self.class.name
      when 'User'
        return if self.role == User::SUPER_ADMIN
        User.admins.where(organization_id: self.organization.id)
      else
        User.super_admins.all
      end

      notify(people, type)
    end

    def notify(users, type)
      users.each do |user|
        user.notifications.create(notification_type: type, notificable: self)
      end
    end
  end
end