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
end
