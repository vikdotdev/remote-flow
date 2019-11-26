class User < ApplicationRecord

  SUPER_ADMIN = 'super_admin'.freeze
  ADMIN = 'admin'.freeze
  MANAGER = 'manager'.freeze

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :organization, optional: true
  accepts_nested_attributes_for :organization
  validates :first_name, length: { maximum: 250 }, presence: true
  validates :last_name, length: { maximum: 250 }, presence: true
  validates :organization_id, presence: true, unless: :super_admin?
  validates :role, inclusion: { in: [SUPER_ADMIN, ADMIN, MANAGER] }

  scope :by_name, -> { order(:first_name) }

  def super_admin?
    self.role == SUPER_ADMIN
  end

  def admin?
    self.role == ADMIN
  end

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

end
