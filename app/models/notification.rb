class Notification < ApplicationRecord

  USER_ADDED = "USER_ADDED".freeze
  USER_DELETED = "USER_DELETED".freeze
  ORGANIZATION_CREATED = "ORGANIZATION_CREATED".freeze

  attr_reader :notificable

  NOTIFICATION_TYPES = [USER_ADDED, USER_DELETED, ORGANIZATION_CREATED]

  belongs_to :notificable, polymorphic: true
  belongs_to :user

  scope :latest_notifications, -> { order(id: :desc).limit(10) }
  scope :unread, -> { where(read: false ) }

  before_create :set_body

  def set_body
    case self.notification_type
    when USER_ADDED
      self.body = "User #{notificable.full_name} has been added to organization"
    when USER_DELETED
      self.body = "User: #{notificable.full_name} has been deleted"
    when ORGANIZATION_CREATED
      debugger
      self.body = "Organization: #{Organization.find(notificable.id).name} was created"
    else
      raise 'Unknown type'
    end
  end
end
