class Feedback < ApplicationRecord
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :name, presence: true, length: { maximum: 250 }

  scope :by_creation_date, -> { order(created_at: :desc) }
end
