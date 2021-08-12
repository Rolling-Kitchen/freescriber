class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum job:{ student: 0, office_worker: 1, researcher: 2, teacher: 3, content_creator: 4, seo: 5, podcaster: 6, media: 7 }
  has_many :videos, dependent: :destroy
end
