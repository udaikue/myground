class AddUserReferencesToDiaries < ActiveRecord::Migration[6.1]
  def change
    add_reference :diaries, :user, null: false, foreign_key: true
  end
end
