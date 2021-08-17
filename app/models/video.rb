class Video < ApplicationRecord
  include PgSearch::Model

  belongs_to :user

  pg_search_scope :search_by_title_or_transcript,
    against: [ :title, :description, :captions ],
    using: {
      tsearch: { prefix: true }
    }
end
