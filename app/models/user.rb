class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :organization, optional: true
  accepts_nested_attributes_for :organization

  validates :first_name, length: { maximum: 250 }, presence: true
  validates :last_name, length: { maximum: 250 }, presence: true

  scope :by_name, -> { order("first_name") }

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
