# frozen_string_literal: true

namespace :myground do
  desc 'Heroku scheduler add-on'
  task update_scraping_and_game: :environment do
    game_card = GameCard.new
    game_card.this_years_schedule
    game_url_array = game_card.today_cards

    # 試合がなければその後の処理は実行しない
    next if game_url_array.empty?

    game_card.save_scrapings(game_url_array)
    game_result = GameResult.new
    game_result.create_games(game_result.responsed_urls)
  end

  task update_game: :environment do
    # scrapingsテーブルに未対応分がなければその後の処理は実行しない
    scrapings = Scraping.not_done
    next if scrapings.empty?

    game_result = GameResult.new
    game_result.create_games(game_result.responsed_urls)
  end

  task add_games: :environment do
    # 5/17
    # Carp vs Giants
    game = Game.new
    game.score_visitor = 2
    game.score_home = 3
    game.hits_visitor = 6
    game.hits_home = 7
    game.errors_visitor = 0
    game.errors_home = 0
    game.date = '2022-05-17'
    game.ballpark_id = 36
    game.team_visitor_id = 6
    game.team_home_id = 1
    game.winning_pitcher = '畠 (2勝0敗1S)'
    game.losing_pitcher = '遠藤 (2勝3敗0S)'
    game.saving_pitcher = nil
    game.homerun_visitor = nil
    game.homerun_home = nil
    game.save

    score = Score.new
    score.game_id = Game.last.id
    score.inning = 1
    score.visitor = '0'
    score.home = '0'
    score.save
    score = Score.new
    score.game_id = Game.last.id
    score.inning = 2
    score.visitor = '2'
    score.home = '0'
    score.save
    score = Score.new
    score.game_id = Game.last.id
    score.inning = 3
    score.visitor = '0'
    score.home = '0'
    score.save
    score = Score.new
    score.game_id = Game.last.id
    score.inning = 4
    score.visitor = '0'
    score.home = '0'
    score.save
    score = Score.new
    score.game_id = Game.last.id
    score.inning = 5
    score.visitor = '0'
    score.home = '0'
    score.save
    score = Score.new
    score.game_id = Game.last.id
    score.inning = 6
    score.visitor = '0'
    score.home = '0'
    score.save
    score = Score.new
    score.game_id = Game.last.id
    score.inning = 7
    score.visitor = '0'
    score.home = '0'
    score.save
    score = Score.new
    score.game_id = Game.last.id
    score.inning = 8
    score.visitor = '0'
    score.home = '0'
    score.save
    score = Score.new
    score.game_id = Game.last.id
    score.inning = 9
    score.visitor = '0'
    score.home = '3X'
    score.save

    # Yaklt vs Tigers
    game = Game.new
    game.score_visitor = 1
    game.score_home = 2
    game.hits_visitor = 4
    game.hits_home = 8
    game.errors_visitor = 0
    game.errors_home = 0
    game.date = '2022-05-17'
    game.ballpark_id = 5
    game.team_visitor_id = 5
    game.team_home_id = 2
    game.winning_pitcher = '大西 (2勝1敗0S)'
    game.losing_pitcher = '岩崎 (1勝1敗5S)'
    game.saving_pitcher = nil
    game.homerun_visitor = '糸原 2号(5回表ソロ)'
    game.homerun_home = nil
    game.save

    score = Score.new
    score.game_id = Game.last.id
    score.inning = 1
    score.visitor = '0'
    score.home = '0'
    score.save
    score = Score.new
    score.game_id = Game.last.id
    score.inning = 2
    score.visitor = '0'
    score.home = '0'
    score.save
    score = Score.new
    score.game_id = Game.last.id
    score.inning = 3
    score.visitor = '0'
    score.home = '0'
    score.save
    score = Score.new
    score.game_id = Game.last.id
    score.inning = 4
    score.visitor = '0'
    score.home = '0'
    score.save
    score = Score.new
    score.game_id = Game.last.id
    score.inning = 5
    score.visitor = '1'
    score.home = '0'
    score.save
    score = Score.new
    score.game_id = Game.last.id
    score.inning = 6
    score.visitor = '0'
    score.home = '0'
    score.save
    score = Score.new
    score.game_id = Game.last.id
    score.inning = 7
    score.visitor = '0'
    score.home = '0'
    score.save
    score = Score.new
    score.game_id = Game.last.id
    score.inning = 8
    score.visitor = '0'
    score.home = '0'
    score.save
    score = Score.new
    score.game_id = Game.last.id
    score.inning = 9
    score.visitor = '0'
    score.home = '2X'
    score.save

    # Lotte vs Eagles
    game = Game.new
    game.score_visitor = 3
    game.score_home = 6
    game.hits_visitor = 9
    game.hits_home = 14
    game.errors_visitor = 1
    game.errors_home = 1
    game.date = '2022-05-17'
    game.ballpark_id = 6
    game.team_visitor_id = 8
    game.team_home_id = 10
    game.winning_pitcher = '佐々木千 (1勝0敗0S)'
    game.losing_pitcher = '田中将 (4勝2敗0S)'
    game.saving_pitcher = '益田 (0勝0敗7S)'
    game.homerun_visitor = nil
    game.homerun_home = '岡 3号(7回裏ソロ)'
    game.save

    score = Score.new
    score.game_id = Game.last.id
    score.inning = 1
    score.visitor = '0'
    score.home = '0'
    score.save
    score = Score.new
    score.game_id = Game.last.id
    score.inning = 2
    score.visitor = '1'
    score.home = '0'
    score.save
    score = Score.new
    score.game_id = Game.last.id
    score.inning = 3
    score.visitor = '0'
    score.home = '1'
    score.save
    score = Score.new
    score.game_id = Game.last.id
    score.inning = 4
    score.visitor = '2'
    score.home = '0'
    score.save
    score = Score.new
    score.game_id = Game.last.id
    score.inning = 5
    score.visitor = '0'
    score.home = '0'
    score.save
    score = Score.new
    score.game_id = Game.last.id
    score.inning = 6
    score.visitor = '0'
    score.home = '0'
    score.save
    score = Score.new
    score.game_id = Game.last.id
    score.inning = 7
    score.visitor = '0'
    score.home = '5'
    score.save
    score = Score.new
    score.game_id = Game.last.id
    score.inning = 8
    score.visitor = '0'
    score.home = '0'
    score.save
    score = Score.new
    score.game_id = Game.last.id
    score.inning = 9
    score.visitor = '0'
    score.home = 'X'
    score.save

    # Orix vs Fighters
    game = Game.new
    game.score_visitor = 0
    game.score_home = 3
    game.hits_visitor = 4
    game.hits_home = 9
    game.errors_visitor = 1
    game.errors_home = 1
    game.date = '2022-05-17'
    game.ballpark_id = 20
    game.team_visitor_id = 7
    game.team_home_id = 11
    game.winning_pitcher = '本田 (1勝0敗1S)'
    game.losing_pitcher = '加藤 (2勝4敗0S)'
    game.saving_pitcher = '平野佳 (2勝2敗12S)'
    game.homerun_visitor = nil
    game.homerun_home = nil
    game.save

    score = Score.new
    score.game_id = Game.last.id
    score.inning = 1
    score.visitor = '0'
    score.home = '0'
    score.save
    score = Score.new
    score.game_id = Game.last.id
    score.inning = 2
    score.visitor = '0'
    score.home = '0'
    score.save
    score = Score.new
    score.game_id = Game.last.id
    score.inning = 3
    score.visitor = '0'
    score.home = '0'
    score.save
    score = Score.new
    score.game_id = Game.last.id
    score.inning = 4
    score.visitor = '0'
    score.home = '0'
    score.save
    score = Score.new
    score.game_id = Game.last.id
    score.inning = 5
    score.visitor = '0'
    score.home = '0'
    score.save
    score = Score.new
    score.game_id = Game.last.id
    score.inning = 6
    score.visitor = '0'
    score.home = '0'
    score.save
    score = Score.new
    score.game_id = Game.last.id
    score.inning = 7
    score.visitor = '0'
    score.home = '2'
    score.save
    score = Score.new
    score.game_id = Game.last.id
    score.inning = 8
    score.visitor = '0'
    score.home = '1'
    score.save
    score = Score.new
    score.game_id = Game.last.id
    score.inning = 9
    score.visitor = '0'
    score.home = 'X'
    score.save

    # Lions vs Softbank
    game = Game.new
    game.score_visitor = 5
    game.score_home = 1
    game.hits_visitor = 6
    game.hits_home = 6
    game.errors_visitor = 1
    game.errors_home = 2
    game.date = '2022-05-17'
    game.ballpark_id = 22
    game.team_visitor_id = 12
    game.team_home_id = 9
    game.winning_pitcher = '津森 (3勝1敗0S)'
    game.losing_pitcher = '平良 (1勝2敗1S)'
    game.saving_pitcher = nil
    game.homerun_visitor = nil
    game.homerun_home = nil
    game.save

    score = Score.new
    score.game_id = Game.last.id
    score.inning = 1
    score.visitor = '0'
    score.home = '0'
    score.save
    score = Score.new
    score.game_id = Game.last.id
    score.inning = 2
    score.visitor = '0'
    score.home = '0'
    score.save
    score = Score.new
    score.game_id = Game.last.id
    score.inning = 3
    score.visitor = '0'
    score.home = '0'
    score.save
    score = Score.new
    score.game_id = Game.last.id
    score.inning = 4
    score.visitor = '0'
    score.home = '0'
    score.save
    score = Score.new
    score.game_id = Game.last.id
    score.inning = 5
    score.visitor = '0'
    score.home = '0'
    score.save
    score = Score.new
    score.game_id = Game.last.id
    score.inning = 6
    score.visitor = '0'
    score.home = '0'
    score.save
    score = Score.new
    score.game_id = Game.last.id
    score.inning = 7
    score.visitor = '0'
    score.home = '0'
    score.save
    score = Score.new
    score.game_id = Game.last.id
    score.inning = 8
    score.visitor = '0'
    score.home = '1'
    score.save
    score = Score.new
    score.game_id = Game.last.id
    score.inning = 9
    score.visitor = '5'
    score.home = '0'
    score.save
  end
end
