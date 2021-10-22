class CreateGames < ActiveRecord::Migration[6.1]
  def change
    create_table :games do |t|
      t.date :date, null: false
      t.string :ballpark, null: false
      t.string :team_home, null: false
      t.string :team_visitor, null: false
      t.integer :score_home, null: false
      t.integer :score_visitor, null: false
      t.integer :hits_home, null: false
      t.integer :hits_visitor, null: false
      t.integer :errors_home, null: false
      t.integer :errors_visitor, null: false
      t.string :winning_pitcher
      t.string :losing_pitcher
      t.string :saving_pitcher
      t.string :homerun_home
      t.string :homerun_visitor

      t.timestamps
    end
  end
end
