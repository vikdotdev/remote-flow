class Notification < ApplicationRecord

  USER_ADDED = "USER_ADDED".freeze
  USER_DELETED = "USER_DELETED".freeze
  ORGANIZATION_CREATED = "ORGANIZATION_CREATED".freeze

  NOTIFICATION_TYPES = [USER_ADDED, USER_DELETED, ORGANIZATION_CREATED]


  before_create :set_body

  belongs_to :notificable, polymorphic: true
  belongs_to :user

  scope :latest_notifications, -> { order(id: :desc).limit(10) }
  scope :unread, -> { where(read: false ) }
  scope :read, -> { where(read: true ) }

  def set_body
    case self.notification_type
    when "USER_ADDED"
      self.body = "User has been added to organization"
    when "USER_DELETED"
      self.body = "User has been deleted"
    when "ORGANIZATION_CREATED"
      self.body = "An Organization was created"
    end
  end
end
