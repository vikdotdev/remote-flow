class Invite < ApplicationRecord
  belongs_to :organization
  belongs_to :sender, class_name: 'User'

  validates :role, inclusion: { in: [User::SUPER_ADMIN, User::ADMIN, User::MANAGER] }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, presence: true

  before_create :generate_invitation_token

  def send_invite_email(path)
    InviteMailer.new_user_invite(self, path).deliver_now
  end

  private

  def generate_invitation_token
    self.token = Digest::SHA1.hexdigest([organization_id, Time.now, rand].join)
  end
end
