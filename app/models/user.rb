class User < ApplicationRecord
  SUPER_ADMIN = 'super_admin'.freeze
  ADMIN = 'admin'.freeze
  MANAGER = 'manager'.freeze

  attr_accessor :skip_organization_validation

  devise :database_authenticatable, :registerable, :trackable,
         :recoverable, :rememberable, :validatable

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

  private

  def organization_validation
    self.skip_organization_validation ||= false
    return unless organization_id.nil?
    return if super_admin? || skip_organization_validation

    errors.add(:organization_id, 'must be present')
  end
end
