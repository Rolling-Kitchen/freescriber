class Video < ApplicationRecord
  include PgSearch::Model
  belongs_to :user
  has_one_attached :photo

  pg_search_scope :search_by_title_or_transcript,
    against: [ :title, :description, :captions ],
    using: {
      tsearch: { prefix: true,
      }
    }

  def extract_url_from_body
    URI.extract(body).first
  end
end
