class Organization < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :device_groups, dependent: :destroy
  has_many :devices, dependent: :destroy
  has_many :channels, dependent: :destroy
  has_many :contents, dependent: :destroy

  after_create :mail_send

  validates :name, presence: true,
                   uniqueness: true

  private
  def mail_send
    SuperAdminMailer.notify_email(self).deliver
  end
end
