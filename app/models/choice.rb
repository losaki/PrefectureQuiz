class Choice < ApplicationRecord
  belongs_to :quiz
  has_one :prefecture
end
