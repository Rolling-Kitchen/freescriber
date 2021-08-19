class Video < ApplicationRecord
  belongs_to :user

  before_save :get_youtube_thumbnail

def get_youtube_thumbnail
  url = extract_url_from_body

  unless url.blank?
    client   = YouTubeIt::Client.new
    response = client.video_by(url)
    self.thumbnail = response.thumbnails.first.url
  end
end

def extract_url_from_body
  URI.extract(body).first
end
end

