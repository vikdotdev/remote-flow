class User < ApplicationRecord  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :organization

  validates_with EmailValidator
  validates :first_name, presence: true
  validates :last_name, presence: true
end
