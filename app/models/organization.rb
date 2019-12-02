class Organization < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :device_groups, dependent: :destroy
  has_many :devices, dependent: :destroy
  has_many :channels, dependent: :destroy
  has_many :contents, dependent: :destroy

  after_create :send_notification

  validates :name, presence: true,
                   uniqueness: true
  scope :by_name, -> { order(:name) }

  private
  def send_notification
    SuperAdminMailer.new_organization_email(self).deliver_now
  end
end
