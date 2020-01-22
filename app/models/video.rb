class Video < Content
  include Searchable
  
  validates :video_url, presence: true,
    format: /\A(https?\:\/\/)?(www\.)?(youtube\.com|youtu\.?be)\/.+\z/
end
