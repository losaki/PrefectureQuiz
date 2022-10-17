class CreateChoices < ActiveRecord::Migration[7.0]
  def change
    create_table :choices do |t|
      t.references :quiz, null: false, foreign_key: true
      t.references :prefecture, null: false, foreign_key: true

      t.timestamps
    end
  end
end
