class Page < Content
  validates :page_title, :page_body, presence: true
end
