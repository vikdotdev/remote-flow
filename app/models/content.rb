class Content < ApplicationRecord
  has_and_belongs_to_many :channels
  belongs_to :organization
end
