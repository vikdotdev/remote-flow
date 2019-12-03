class Content < ApplicationRecord
  VIDEO = 'Video'.freeze
  GALLERY = 'Gallery'.freeze
  TYPES = [VIDEO, GALLERY].freeze

  has_and_belongs_to_many :channels
  belongs_to :organization

  scope :videos, -> { where(type: 'Video') }
end
