class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  mount_uploader :avatar, AvatarUploader

  belongs_to :organization
  accepts_nested_attributes_for :organization

  def full_name
    "#{self.first_name} #{self.last_name}"
  end
end
