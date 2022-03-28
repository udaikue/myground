class CreateScrapings < ActiveRecord::Migration[6.1]
  def change
    create_table :scrapings do |t|
      t.string :url, null: false
      t.date :game_date, null: false
      t.boolean :done, null: false, default: false

      t.timestamps
    end
  end
end
