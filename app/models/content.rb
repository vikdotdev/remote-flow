class Content < ApplicationRecord
  VIDEO = 'Video'.freeze
  GALLERY = 'Gallery'.freeze
  TYPES = [VIDEO, GALLERY].freeze

  has_and_belongs_to_many :channels
  belongs_to :organization

  scope :by_title, -> { order('title') }
  scope :videos, -> { where(type: 'Video') }

  validates :title, presence: true
end
