class Quiz < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :played_quizzes, dependent: :destroy
  has_many :choices, dependent: :destroy
  accepts_nested_attributes_for :choices, allow_destroy: true
  has_one :prefecture
  mount_uploader :photo, PhotoUploader

  validates :photo, presence: true
  validates :prefecture_id, presence: true
  validates :hint, length: { maximum: 99 }
  validates :description, length: { maximum: 99 }
  
end
