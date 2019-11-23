class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :organization, optional: true
  accepts_nested_attributes_for :organization

  attr_accessor :current_user

  validates :first_name, length: { maximum: 250 }, presence: true
  validates :last_name, length: { maximum: 250 }, presence: true
  validates :organization_id, presence: true, unless: :super_admin?
  validates :role, inclusion: { in: %w(admin manager) }, unless: :current_user_is_super_admin?
  validates :role, inclusion: { in: %w(super_admin admin manager) }, if: :current_user_is_super_admin?

  scope :by_name, -> { order('first_name') }

  def current_user_is_super_admin?
    current_user.role == 'super_admin'
  end

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
