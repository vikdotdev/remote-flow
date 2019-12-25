class Notification < ApplicationRecord

  USER_ADDED = "A new user has been added to organization: ".freeze
  USER_DELETED = "User has been deleted: ".freeze
  ORGANIZATION_CREATED = "A new organization has been created: ".freeze

  belongs_to :notificable, polymorphic: true
  belongs_to :user

  scope :latest_notifications, -> { order(id: :desc).limit(10) }
  scope :unread, -> { where(read: false ) }
  scope :read, -> { where(read: true ) }

  def created_time
  end
end
