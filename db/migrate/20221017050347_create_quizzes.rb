class CreateQuizzes < ActiveRecord::Migration[7.0]
  def change
    create_table :quizzes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :prefecture, null: false, foreign_key: true
      t.string :hint
      t.string :description
      t.integer :play_count
      t.integer :correct_count
      t.integer :difficulty

      t.timestamps
    end
  end
end
