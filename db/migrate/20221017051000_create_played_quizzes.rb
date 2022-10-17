class CreatePlayedQuizzes < ActiveRecord::Migration[7.0]
  def change
    create_table :played_quizzes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :quiz, null: false, foreign_key: true

      t.timestamps
    end
  end
end
