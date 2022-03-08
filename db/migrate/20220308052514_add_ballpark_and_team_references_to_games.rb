class AddBallparkAndTeamReferencesToGames < ActiveRecord::Migration[6.1]
  def change
    add_reference :games, :ballpark, null: false, foreign_key: true
    add_reference :games, :team_home, null: false, foreign_key: { to_table: :teams }
    add_reference :games, :team_visitor, null: false, foreign_key: { to_table: :teams }
  end
end
