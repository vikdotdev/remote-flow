class Organization < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :device_groups, dependent: :destroy
  has_many :devices, dependent: :destroy
  has_many :channels, dependent: :destroy
  has_many :contents, dependent: :destroy
  has_many :invites, dependent: :delete_all

  after_create :send_email_notification
  after_create :send_slack_notification
  before_create :generate_token

  validates :name, presence: true,
                   uniqueness: true

  scope :by_name, -> { order(:name) }

  mount_uploader :logo, LogoUploader

  after_create :notify_created!
  before_destroy :notify_deleted!
  private

  def send_slack_notification
    notifier = Slack::Notifier.new(
      SLACK_CONFIG[:token],
      channel: SLACK_CONFIG[:channel],
      username: SLACK_CONFIG[:username]
    )

    notifier.ping "Organization #{name} was just created!"
  end

  def send_email_notification
    SuperAdminMailer.new_organization_email(self).deliver_now
  end

  def generate_token
    self.token = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless Organization.exists?(token: random_token)
    end
  end

  def notify_created!
    User.super_admins.each do |super_admin|
      super_admin.notifications.create(notification_type: Notification::ORGANIZATION_CREATED, notificable: self)
    end
  end

  def notify_deleted!
    User.super_admins.each do |super_admin|
      super_admin.notifications.create(notification_type: Notification::ORGANIZATION_DELETED, notificable: self)
    end
  end
end
