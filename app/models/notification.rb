class Notification < ApplicationRecord

  USER_ADDED = "USER_ADDED".freeze
  USER_DELETED = "USER_DELETED".freeze
  ORGANIZATION_CREATED = "ORGANIZATION_CREATED".freeze
  ORGANIZATION_DELETED = "ORGANIZATION_DELETED".freeze
  NOTIFICATION_TYPES = [USER_ADDED, USER_DELETED, ORGANIZATION_CREATED, ORGANIZATION_DELETED]

  RESOURCE_EVENTS = {
      User: { created: USER_ADDED,
              destroyed: USER_DELETED },

      Organization: { created: ORGANIZATION_CREATED,
                      destroyed: ORGANIZATION_DELETED }
    }

  belongs_to :notificable, polymorphic: true
  belongs_to :user

  scope :recent, -> { order(id: :desc).limit(10) }
  scope :unread, -> { where(read: false ) }

  def body
    case self.notification_type
    when USER_ADDED
      "User: #{self.notificable.full_name} has been added to organization"
    when USER_DELETED
      "User: #{self.notificable.full_name} has been deleted"
    when ORGANIZATION_CREATED
      "Organization: #{self.notificable.name} was created"
    when ORGANIZATION_DELETED
      "Organization: #{self.notificable.name} was deleted"
    else
      raise 'Unknown type'
    end
  end
end
