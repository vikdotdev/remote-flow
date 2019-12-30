class Channel < ApplicationRecord
  belongs_to :organization
  has_and_belongs_to_many :device_groups
  has_and_belongs_to_many :contents

  after_destroy :send_email_notification

  validates :name, presence: true,
                   length: { minimum: 2,
                             maximum: 255 }

  scope :by_name, -> { order(:name) }

  private

  def send_email_notification
    AdminMailer.delete_channel_email(self).deliver_now
  end
end
