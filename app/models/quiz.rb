class Quiz < ApplicationRecord
  belongs_to :user
  has_many :likes
  has_many :played_quizzes
  has_many :choices
  has_one :prefecture
  mount_uploader :photo, PhotoUploader
end
