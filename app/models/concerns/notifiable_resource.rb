module NotifiableResource
  extend ActiveSupport::Concern

  included do
    after_commit :notify_created!, on: :create
    after_commit :notify_deleted!, on: :destroy

    private

    def notify_created!
      notify_event!(:created)
    end

    def notify_deleted!
      notify_event!(:destroyed)
    end

    def notify_event!(callback_type)
      type = Notification::RESOURCE_EVENTS[self.class.name.to_sym][callback_type]

      people = case self.class.name
      when 'User'
        if self.organization
          organization.users.admins.where.not(id: self.id)
        else
          User.none
        end
      else
        User.super_admins
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
