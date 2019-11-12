class User < ApplicationRecord
  include ActiveModel::Validations
  
  belongs_to :organization

  validates_with EmailValidator
  validates :first_name, presence: true
  validates :last_name, presence: true
end
