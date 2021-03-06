class Organization < ApplicationRecord
  include NotifiableResource

  has_many :users, dependent: :destroy
  has_many :device_groups, dependent: :destroy
  has_many :devices, dependent: :destroy
  has_many :channels, dependent: :destroy
  has_many :contents, dependent: :destroy
  has_many :invites, dependent: :delete_all
  has_many :backgrounds, dependent: :delete_all

  after_create :send_email_notification
  after_create :send_slack_notification
  before_create :generate_token

  validates :name, presence: true,
                   uniqueness: true

  scope :by_name, -> { order(:name) }

  mount_uploader :logo, LogoUploader

  private

  def send_slack_notification
    SlackNotifier.ping("Organization #{name} was just created!")
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
end
