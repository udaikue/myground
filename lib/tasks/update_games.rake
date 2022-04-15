# frozen_string_literal: true

require_relative '../../app/models/game_card'
require_relative '../../app/models/game_result'

namespace :myground do
  desc 'Heroku scheduler add-on'
  task update_scraping_and_game: :environment do
    game_card = GameCard.new
    game_url_array = game_card.today_cards
    # 試合がなければその後の処理は実行しない
    next if game_url_array.empty?

    game_card.save_scrapings(game_url_array)
    game_result = GameResult.new
    game_result.create_games(game_result.responsed_urls)
  end

  task update_game: :environment do
    game_result = GameResult.new
    # scrapingsテーブルに未対応分がなければその後の処理は実行しない
    next if game_result.scrapings.empty?

    game_result.create_games(game_result.responsed_urls)
  end
end
