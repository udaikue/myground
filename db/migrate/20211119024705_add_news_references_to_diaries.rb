class AddNewsReferencesToDiaries < ActiveRecord::Migration[6.1]
  def change
    add_reference :diaries, :news, null: false, foreign_key: true
  end
end
