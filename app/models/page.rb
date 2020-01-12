class Page < Content
  include Searchable
  index_name([Rails.env,base_class.to_s.pluralize.underscore].join('_'))

  validates :body, presence: true
end
