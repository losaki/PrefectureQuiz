class Quiz < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :played_quizzes, dependent: :destroy
  has_many :choices, dependent: :destroy
  accepts_nested_attributes_for :choices, allow_destroy: true
  has_one :prefecture
  has_one_attached :photo

  validates :photo, content_type: { in: %w[image/jpeg image/gif image/png], message: '有効なフォーマットではありません' },
                    size: { less_than: 2.megabytes, message: '2MBを超える画像はアップロードできません' },
                    presence: true
  validates :prefecture_id, presence: true
  validates :hint, length: { maximum: 99 }
  validates :description, length: { maximum: 99 }

  def self.sorted_quizzes(sort_param, page)
    case sort_param
    when 'posted_at_desc'
      order(created_at: :desc).includes(:user).page(page)
    when 'posted_at_asc'
      order(created_at: :asc).includes(:user).page(page)
    when 'play_count_desc'
      order(play_count: :desc).includes(:user).page(page)
    when 'play_count_asc'
      order(play_count: :asc).includes(:user).page(page)
    when 'correct_rate_desc'
      order(Arel.sql("(CASE WHEN play_count > 0 THEN correct_count::float / play_count ELSE 0 END) DESC")).includes(:user).page(page)
    when 'correct_rate_asc'
      order(Arel.sql("(CASE WHEN play_count > 0 THEN correct_count::float / play_count ELSE 0 END) ASC")).includes(:user).page(page)
    else
      order(created_at: :desc).includes(:user).page(page) # デフォルトのソート順
    end
  end
end
