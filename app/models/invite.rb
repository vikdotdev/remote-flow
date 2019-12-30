class Invite < ApplicationRecord
  belongs_to :organization
  belongs_to :sender, class_name: 'User'

  scope :by_creation_date, -> { order(:created_at) }

  validates :role, inclusion: { in: [User::SUPER_ADMIN, User::ADMIN, User::MANAGER] }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, presence: true,
    uniqueness: { scope: :organization }

  before_create :generate_invitation_token

  def send_invite_email
    InviteMailer.new_user_invite(self).deliver_now
  end

  private

  def generate_invitation_token
    self.token = Digest::SHA1.hexdigest([organization_id, Time.now, rand].join)
  end
end
