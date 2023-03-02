class ChangeColumnDefaultToQuizzes < ActiveRecord::Migration[7.0]
  def change
    change_column_default :quizzes, :play_count, from: nil, to: 0
    change_column_default :quizzes, :correct_count, from: nil, to: 0
  end
end
