class AddReferencesToDiaries < ActiveRecord::Migration[6.1]
  def change
    add_reference :diaries, :game, null: false, foreign_key: true
  end
end
