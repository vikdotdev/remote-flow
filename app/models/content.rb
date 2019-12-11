class Content < ApplicationRecord
  VIDEO = 'Video'.freeze
  GALLERY = 'Gallery'.freeze
  PRESENTATION = 'Presentation'.freeze
  TYPES = [VIDEO, GALLERY, PRESENTATION].freeze

  has_and_belongs_to_many :channels
  belongs_to :organization

  scope :by_title, -> { order(:title) }
  scope :videos, -> { where(type: 'Video') }
  scope :presentation, -> { where(type: 'Presentation') }

  validates :title, presence: true

  def file_name
    File.basename(self.file.url)
  end
end
