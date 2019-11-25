class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :organization, optional: true
  accepts_nested_attributes_for :organization

  SUPER_ADMIN = 'super_admin'.freeze
  ADMIN = 'admin'.freeze
  MANAGER = 'manager'.freeze

  validates :first_name, length: { maximum: 250 }, presence: true
  validates :last_name, length: { maximum: 250 }, presence: true
  validates :organization_id, presence: true, unless: :super_admin?
  validates :role, inclusion: { in: [SUPER_ADMIN, ADMIN, MANAGER] }

  scope :by_name, -> { order('first_name') }

  def super_admin?
    self.role == 'super_admin'
  end

  def admin?
    self.role == 'admin'
  end

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

end
