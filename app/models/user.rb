class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :password, length: { minimum: 6 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, uniqueness: true
  validates :email, presence: true
  validates :name, presence: true, length: { maximum: 255 }

  has_many :quizzes, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :like_quizzes, through: :likes, source: :quiz
  has_many :played_quizzes
  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications

  def own?(object)
    id == object.user_id
  end

  def like(quiz)
    like_quizzes << quiz
  end

  def unlike(quiz)
    like_quizzes.destroy(quiz)
  end

  def like?(quiz)
    like_quizzes.include?(quiz)
  end
end
