class AddDiaryReferencesToLinks < ActiveRecord::Migration[6.1]
  def change
    add_reference :links, :diary, null: false, foreign_key: true
  end
end
