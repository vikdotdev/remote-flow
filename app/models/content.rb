class Content < ApplicationRecord
  VIDEO = 'Video'.freeze
  GALLERY = 'Gallery'.freeze
  PAGE = 'PAGE'.freeze
  TYPES = [VIDEO, GALLERY, PAGE].freeze

  has_and_belongs_to_many :channels
  belongs_to :organization

  scope :by_title, -> { order(:title) }
  scope :videos, -> { where(type: 'Video') }
  scope :pages, -> { where(type: 'Page') }

  validates :title, presence: true
end
