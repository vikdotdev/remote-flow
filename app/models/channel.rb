class Channel < ApplicationRecord
  include Searchable
  
  belongs_to :organization
  has_and_belongs_to_many :device_groups
  has_and_belongs_to_many :contents

  after_destroy :notify_deleted

  validates :name, presence: true,
                   length: { minimum: 2,
                             maximum: 255 }

  scope :by_name, -> { order(:name) }

  private

  def notify_deleted
    AdminMailer.delete_channel(self).deliver_now
  end
end
