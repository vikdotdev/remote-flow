class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :organization
  accepts_nested_attributes_for :organization

  validates :first_name, length: { maximum: 250 }, presence: true
  validates :last_name, length: { maximum: 250 }, presence: true

  def super_admin?
    self.role == 'super_admin'
  end

  def admin?
    self.role == 'admin'
  end

end
