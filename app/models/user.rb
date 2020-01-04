class User < ApplicationRecord
  SUPER_ADMIN = 'super_admin'.freeze
  ADMIN = 'admin'.freeze
  MANAGER = 'manager'.freeze

  attr_accessor :skip_organization_validation
  attr_accessor :skip_password_validation


  devise :database_authenticatable, :registerable, :trackable,
         :recoverable, :rememberable, :validatable, :omniauthable,
        omniauth_providers: [:google_oauth2]

  mount_uploader :avatar, AvatarUploader

  belongs_to :organization, optional: true
  has_many :sent_invites, class_name: 'Invite', foreign_key: 'sender_id'
  has_many :notifications, as: :notificable, dependent: :destroy
  accepts_nested_attributes_for :organization

  validates :first_name, length: { maximum: 250 }, presence: true
  validates :last_name, length: { maximum: 250 }, presence: true
  validate :organization_validation
  validates :role, inclusion: { in: [SUPER_ADMIN, ADMIN, MANAGER] }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true, if: :password

  scope :by_name, -> { order(:first_name) }
  scope :super_admins, -> { where(role: SUPER_ADMIN) }
  scope :admins, -> { where(role: ADMIN) }

  after_create :send_notification_about_creation

  def super_admin?
    self.role == SUPER_ADMIN
  end

  def admin?
    self.role == ADMIN
  end

  def manager?
    self.role == MANAGER
  end

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def self.to_csv
    attributes = %w{id email first_name last_name role organization}
    CSV.generate(headers: true) do |csv|
      csv << attributes
      left_joins(:organization).select('users.*, organizations.name as organization_name').each do |user|
        csv << [
          user.id,
          user.first_name,
          user.last_name,
          user.email,
          user.role,
          (user.organization_name || 'N/A')
        ]
      end
    end
  end

  def self.from_omniauth(access_token)
    data = access_token[:info]
    google_user = User.find_or_initialize_by(email: data[:email]).tap do |user|
      if user.new_record?
        user.assign_attributes(first_name: data[:first_name],
          last_name: data[:last_name],
          email: data[:email],
          role: ADMIN,
          google_token: access_token[:credentials][:token],
          google_refresh_token: access_token[:credentials][:refresh_token]
        )
        user.save
      end
    end
    google_user
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if session["devise.google_data"].present?
        user.email = session.dig('devise.google_data', 'info', 'email') if user.email.blank?
        user.first_name = session.dig('devise.google_data', 'info', 'first_name') if user.first_name.blank?
        user.last_name = session.dig('devise.google_data', 'info', 'last_name') if user.last_name.blank?
      end
    end
  end

  private

  def organization_validation
    self.skip_organization_validation ||= false
    return unless organization_id.nil?
    return if super_admin? || skip_organization_validation

    errors.add(:organization_id, 'must be present')
  end

  def send_notification_about_creation
    User.admins.where(organization_id: self.organization_id).each do |admin|
      admin.notifications << Notification.new(notification_type: Notification::USER_ADDED, notificable: self, user: admin)
    end
  end

  def send_notification_about_deletion
    User.admins.where(organization_id: self.organization_id).each do |admin|
      admin.notifications << Notification.new(notification_type: Notification::USER_DELETED, notificable: self, user: admin)
    end
  end

  def password_required?
    !skip_password_validation && super
  end
end
