class Feedback < ApplicationRecord
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, presence: true
  validates :name, presence: true, length: { maximum: 250 }

  scope :by_creation_date, -> { order(:create_at) }
end
