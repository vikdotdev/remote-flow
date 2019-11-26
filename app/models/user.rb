class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :organization
  accepts_nested_attributes_for :organization

  def full_name
    "#{self.first_name} #{self.last_name}"
  end
end
