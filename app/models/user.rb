class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :organization
  accepts_nested_attributes_for :organization

  def super_admin?
    self.role == 'super_admin'
  end
end
