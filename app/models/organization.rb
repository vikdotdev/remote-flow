require 'slack-notifier'

class Organization < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :device_groups, dependent: :destroy
  has_many :devices, dependent: :destroy
  has_many :channels, dependent: :destroy
  has_many :contents, dependent: :destroy
  has_many :invites, dependent: :delete_all

  after_create :send_email_notification, :send_slack_notification

  validates :name, presence: true,
                   uniqueness: true

  scope :by_name, -> { order(:name) }

  mount_uploader :logo, LogoUploader

  private

  def send_slack_notification
    config = Rails.application.config.SLACK_CONFIG
    notifier = Slack::Notifier.new(
      config[:token],
      channel: config[:channel],
      username: config[:username]
    )

    notifier.ping "Organization #{name} was just created!"
  end

  def send_email_notification
    SuperAdminMailer.new_organization_email(self).deliver_now
  end
end
