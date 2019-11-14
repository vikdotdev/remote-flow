class Content < ApplicationRecord
    belongs_to :channel
    belongs_to :organization
    has_and_belongs_to_many :channels
end
