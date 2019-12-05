class Video < Content
  validates :video_url, presence: true,
    format: /\A(https?\:\/\/)?(www\.)?(youtube\.com|youtu\.?be)\/.+\z/
end
