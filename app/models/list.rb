class List < ApplicationRecord
  has_many :bookmarks, dependent: :destroy
  has_many :videos, through: :bookmarks
  belongs_to :user

  validates :name, uniqueness: true, presence: true
end
