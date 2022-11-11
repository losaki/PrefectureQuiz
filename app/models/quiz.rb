class Quiz < ApplicationRecord
  belongs_to :user
  has_many :likes
  has_many :played_quizzes
  has_many :choices
  accepts_nested_attributes_for :choices, allow_destroy: true
  has_one :prefecture
  mount_uploader :photo, PhotoUploader
end
