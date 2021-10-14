class CreateDiaries < ActiveRecord::Migration[6.1]
  def change
    create_table :diaries do |t|
      t.boolean :open, null: false, default: false
      t.text :comment

      t.timestamps
    end
  end
end
