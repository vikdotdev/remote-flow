class Notification < ApplicationRecord

  USER_ADDED = "USER_ADDED".freeze
  USER_DELETED = "USER_DELETED".freeze
  ORGANIZATION_CREATED = "ORGANIZATION_CREATED".freeze
  ORGANIZATION_DELETED = "ORGANIZATION_DELETED".freeze

  attr_reader :notificable

  NOTIFICATION_TYPES = [USER_ADDED, USER_DELETED, ORGANIZATION_CREATED, ORGANIZATION_DELETED]

  belongs_to :notificable, polymorphic: true
  belongs_to :user

  scope :recent, -> { order(id: :desc).limit(10) }
  scope :unread, -> { where(read: false ) }

  before_create :set_body

  def set_body
    case self.notification_type
    when USER_ADDED
      self.body = "User: #{self.notificable.full_name} has been added to organization"
    when USER_DELETED
      self.body = "User: #{self.notificable.full_name} has been deleted"
    when ORGANIZATION_CREATED
      self.body = "Organization: #{self.notificable.name} was created"
    when ORGANIZATION_DELETED
      self.body = "Organization: #{self.notificable.name} was deleted"
    else
      raise 'Unknown type'
    end
  end
end
