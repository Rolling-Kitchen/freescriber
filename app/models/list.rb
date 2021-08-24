class List < ApplicationRecord
  has_many :videos
  belongs_to :user

  validates :name, uniqueness: true, presence: true
end
