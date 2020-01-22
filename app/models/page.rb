class Page < Content
  include Searchable
  
  validates :body, presence: true
end
