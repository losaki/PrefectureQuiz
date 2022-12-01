class Choice < ApplicationRecord
  belongs_to :quiz
  has_one :prefecture
  
  validates :prefecture_id, presence: true
end
