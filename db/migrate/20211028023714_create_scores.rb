class CreateScores < ActiveRecord::Migration[6.1]
  def change
    create_table :scores do |t|
      t.integer :inning, null: false
      t.string :home
      t.string :visitor
      t.references :game, null: false, foreign_key: true

      t.timestamps
    end
  end
end
