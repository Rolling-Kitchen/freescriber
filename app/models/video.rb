class Video < ApplicationRecord
  include PgSearch::Model

  belongs_to :user

#   before_save :get_youtube_thumbnail

# def get_youtube_thumbnail
#   url = extract_url_from_body

#   unless url.blank?
#     client   = YouTubeIt::Client.new
#     response = client.video_by(url)
#     self.thumbnail = response.thumbnails.first.url
#   end

  pg_search_scope :search_by_title_or_transcript,
    against: [ :title, :description, :captions ],
    using: {
      tsearch: { prefix: true }
    }

end

def extract_url_from_body
  URI.extract(body).first
end
end

