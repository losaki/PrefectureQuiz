class Quiz < ApplicationRecord
  belongs_to :user
  has_many :likes
  has_many :played_quizzes
  has_one :prefecture
end
