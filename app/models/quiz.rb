class Quiz < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :played_quizzes, dependent: :destroy
  has_many :choices, dependent: :destroy
  accepts_nested_attributes_for :choices, allow_destroy: true
  has_one :prefecture
  has_one_attached :photo

  validates :photo, content_type:{ in: %w[image/jpeg image/gif image/png], message: "有効なフォーマットではありません"},
                    size: { less_than: 2.megabytes, message: "2MBを超える画像はアップロードできません" }
  validates :prefecture_id, presence: true
  validates :hint, length: { maximum: 99 }
  validates :description, length: { maximum: 99 }
  
end
