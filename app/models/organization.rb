class Organization < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :device_groups, dependent: :destroy
  has_many :devices, dependent: :destroy
  has_many :channels, dependent: :destroy
  has_many :contents, dependent: :destroy
  has_many :invites, dependent: :delete_all

  after_create :send_email_notification
  after_create :send_slack_notification
  after_create :initialization_of_token

  validates :name, presence: true,
                   uniqueness: true

  scope :by_name, -> { order(:name) }

  mount_uploader :logo, LogoUploader

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

  def initialization_of_token
    self.token = SecureRandom.hex(10)
  end
end
